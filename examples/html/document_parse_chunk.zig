const std = @import("std");
const print = std.debug.print;

const serialize = @import("base.zig").serialize;

const core = @import("lexbor").core;
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
    var status: core.Status = undefined;

    // Initialization
    const doc = html.document.create();
    if (doc == null) return error.FailedToCreate;
    defer _ = html.document.destroy(doc);

    // Parse HTML
    status = html.document.parseChunkBegin(doc);
    if (status != core.Status.ok) return error.FailedToParseChunkBegin;

    for (input) |in| {
        status = html.document.parseChunk(doc, &in[0], in.len);
        if (status != core.Status.ok) return error.FailedToParseChunk;
    }

    status = html.document.parseChunkEnd(doc);
    if (status != core.Status.ok) return error.FailedToParseChunkEnd;

    // Print Result
    print("HTML Tree:\n", .{});
    serialize(dom.interface.node(doc));
}
