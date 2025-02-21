const std = @import("std");
const expectEqual = std.testing.expectEqual;
const expectEqualSlices = std.testing.expectEqualSlices;
const panic = std.debug.panic;

const core = @import("lexbor").core;
const html = @import("lexbor").html;
const tag = @import("lexbor").tag;
const dom = @import("lexbor").dom;

test "document_title" {
    const input = "<head><title>  Oh,    my...   </title></head>";

    // Initialization
    const doc = try html.document.create();
    defer html.document.destroy(doc);

    // Parse HTML
    try html.document.parse(doc, input);

    // Get title
    if (html.document.getTitle(doc)) |title| {
        try expectEqualSlices(u8, "Oh, my...", title);
    }

    // Get raw title
    if (html.document.getRawTitle(doc)) |raw_title| {
        try expectEqualSlices(u8, "  Oh,    my...   ", raw_title);
    }

    // Set new title
    try html.document.setTitle(doc, "We change title");

    // Get new title
    if (html.document.getTitle(doc)) |new_title| {
        try expectEqualSlices(u8, "We change title", new_title);
    }

    // Print HTML tree
    // serialize(dom.interface.node(doc));
}

test "document_parse_chunk" {
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

    // Get title
    if (html.document.getTitle(doc)) |title| {
        try expectEqualSlices(u8, "HTML chunks parsing", title);
    }

    // Print Result
    // serialize(dom.interface.node(doc));
}

test "document_create" {
    var tag_name_len: usize = undefined;

    const input = "";

    // Initialization
    const parser = try html.parser.create();

    try html.parser.init(parser);

    // Parse
    const doc = try html.parser.parse(parser, input, input.len);
    defer html.document.destroy(doc);

    html.parser.destroy(parser);

    const body = html.document.bodyElement(doc);

    var cur: tag.IdEnum = .a;
    const last: tag.IdEnum = ._last_entry;

    while (@intFromEnum(cur) < @intFromEnum(last)) : (cur = @enumFromInt(@intFromEnum(cur) + 1)) {
        const tag_name = try tag.nameById(cur, &tag_name_len);
        const element = try dom.document.createElement(&doc.dom_document, tag_name, tag_name_len, null);

        if (html.tag.isVoid(cur)) {
            // std.debug.print("Create element by tag name \"{s}\"\n", .{tag_name});
        } else {
            // std.debug.print("Create element by tag name \"{s}\" and append text node\n", .{tag_name});
            const text = try dom.document.createTextNode(&doc.dom_document, tag_name, tag_name_len);
            dom.node.insertChild(dom.interface.node(element), dom.interface.node(text));
        }
        // serializeNode(dom.interface.node(element));
        dom.node.insertChild(dom.interface.node(body), dom.interface.node(element));
    }
    // Print Result
    // serialize(dom.interface.node(doc));
}

pub fn serialize(node: *dom.NodeType) void {
    const status = html.serialize.prettyTreeCb(node, @intFromEnum(html.serialize.Opt.undef), 0, serializerCallback, null);

    if (status != @intFromEnum(core.Status.ok)) {
        panic("Failed to serialization HTML tree", .{});
    }
}

pub fn serializeNode(node: *dom.NodeType) void {
    const status = html.serialize.prettyCb(node, @intFromEnum(html.serialize.Opt.undef), 0, serializerCallback, null);

    if (status != @intFromEnum(core.Status.ok)) {
        panic("Failed to serialization HTML tree", .{});
    }
}

fn serializerCallback(data: ?[*:0]const core.CharType, len: usize, ctx: ?*anyopaque) callconv(.C) core.StatusType {
    _ = ctx;
    _ = len;
    std.debug.print("{s}", .{data.?});
    return @intFromEnum(core.Status.ok);
}

// test {
//     _ = @import("core.zig");
//     _ = @import("core/array_obj.zig");
//     _ = @import("core/avl.zig");
//     _ = @import("core/bst.zig");
//     _ = @import("core/bst_map.zig");
//     _ = @import("core/dobject.zig");
//     _ = @import("core/hash.zig");
//     _ = @import("core/in.zig");
//     _ = @import("core/mem.zig");
//     _ = @import("core/mraw.zig");
//     _ = @import("core/str.zig");
// }
