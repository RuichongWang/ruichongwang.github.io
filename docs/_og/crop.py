#!/usr/bin/env python3
"""Crop a PNG to its top-left WxH. Used by publish.sh when drawing share cards.

Chrome's headless `--screenshot` writes an image the size of `--window-size`,
but only paints the top `innerHeight` rows of it — the browser frame eats the
difference, 87px on Chromium 141/Linux, and nothing on the command line reports
how much. So publish.sh renders into a deliberately oversized window, which
guarantees the whole card lands inside the painted region, and this trims the
result back to the card.

Stdlib only: zlib and struct. The alternative was ImageMagick or Pillow, and a
blog with two posts should not acquire an image toolchain to draw a rectangle.
"""
import struct
import sys
import zlib


def read_rgb(path):
    """Return (width, height, channels, unfiltered pixel bytes)."""
    data = open(path, "rb").read()
    if data[:8] != b"\x89PNG\r\n\x1a\n":
        raise SystemExit(f"{path}: not a PNG")
    pos, idat, w, h, depth, color = 8, [], None, None, None, None
    while pos < len(data):
        (length,) = struct.unpack(">I", data[pos : pos + 4])
        kind = data[pos + 4 : pos + 8]
        chunk = data[pos + 8 : pos + 8 + length]
        pos += 12 + length
        if kind == b"IHDR":
            w, h, depth, color, _, _, interlace = struct.unpack(">IIBBBBB", chunk[:13])
            if depth != 8 or color not in (2, 6) or interlace:
                raise SystemExit(f"{path}: expected an 8-bit non-interlaced RGB(A) PNG")
        elif kind == b"IDAT":
            idat.append(chunk)
        elif kind == b"IEND":
            break

    channels = 3 if color == 2 else 4
    raw = zlib.decompress(b"".join(idat))
    stride = w * channels
    out = bytearray()
    prev = bytearray(stride)
    pos = 0
    for _ in range(h):
        filt = raw[pos]
        pos += 1
        line = bytearray(raw[pos : pos + stride])
        pos += stride
        if filt:
            for x in range(stride):
                a = line[x - channels] if x >= channels else 0
                b = prev[x]
                c = prev[x - channels] if x >= channels else 0
                if filt == 1:
                    line[x] = (line[x] + a) & 255
                elif filt == 2:
                    line[x] = (line[x] + b) & 255
                elif filt == 3:
                    line[x] = (line[x] + ((a + b) >> 1)) & 255
                elif filt == 4:
                    p = a + b - c
                    pa, pb, pc = abs(p - a), abs(p - b), abs(p - c)
                    pred = a if (pa <= pb and pa <= pc) else (b if pb <= pc else c)
                    line[x] = (line[x] + pred) & 255
                else:
                    raise SystemExit(f"{path}: unknown PNG filter {filt}")
        out += line
        prev = line
    return w, h, channels, bytes(out)


def write_rgb(path, w, h, channels, pixels):
    stride = w * channels
    body = bytearray()
    for y in range(h):
        body += b"\x00" + pixels[y * stride : (y + 1) * stride]

    def chunk(kind, payload):
        return (
            struct.pack(">I", len(payload))
            + kind
            + payload
            + struct.pack(">I", zlib.crc32(kind + payload) & 0xFFFFFFFF)
        )

    color = 2 if channels == 3 else 6
    with open(path, "wb") as fh:
        fh.write(b"\x89PNG\r\n\x1a\n")
        fh.write(chunk(b"IHDR", struct.pack(">IIBBBBB", w, h, 8, color, 0, 0, 0)))
        fh.write(chunk(b"IDAT", zlib.compress(bytes(body), 9)))
        fh.write(chunk(b"IEND", b""))


def main():
    if len(sys.argv) != 5:
        raise SystemExit("usage: crop.py IN.png OUT.png WIDTH HEIGHT")
    src, dst, want_w, want_h = sys.argv[1], sys.argv[2], int(sys.argv[3]), int(sys.argv[4])
    w, h, channels, pixels = read_rgb(src)
    if w < want_w or h < want_h:
        raise SystemExit(f"{src}: {w}x{h} is smaller than the requested {want_w}x{want_h}")
    stride = w * channels
    keep = want_w * channels
    out = bytearray()
    for y in range(want_h):
        out += pixels[y * stride : y * stride + keep]
    write_rgb(dst, want_w, want_h, channels, bytes(out))


if __name__ == "__main__":
    main()
