const std = @import("std");
const print = std.debug.print;

const serialize = @import("base.zig").serialize;

const dom = @import("lexbor").dom;
const html = @import("lexbor").html;

pub fn main() !void {
    const input = [_][]const u8{
        "<!DOCT",
        "YPE htm",
        "l>",
        "<html><head>",
        "<ti",
        "tle>HTML chun",
        "ks parsing</",
        "title>",
        "</head><bod",
        "y><div cla",
        "ss=",
        "\"bestof",
        "class",
        "\">",
        "good for me",
        "</div>",
    };

    // Initialization
    const doc = try html.document.create();
    defer html.document.destroy(doc);

    // Parse HTML
    try html.document.parseChunkBegin(doc);

    for (input) |h| {
        try html.document.parseChunk(doc, &h[0], h.len);
    }

    try html.document.parseChunkEnd(doc);

    // Print Result
    print("HTML Tree:\n", .{});
    serialize(dom.interface.node(doc));
}
