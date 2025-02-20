const std = @import("std");
const expectEqual = std.testing.expectEqual;
const expectEqualSlices = std.testing.expectEqualSlices;
const panic = std.debug.panic;

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
    // try html.document.serialize(doc, .LXB_HTML_SERIALIZE_OPT_UNDEF);
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
    try html.document.serialize(doc, .LXB_HTML_SERIALIZE_OPT_UNDEF);
}

test "document_create" {
    var tag_name_len: usize = undefined;

    const input = "";

    // Initialization
    const parser = try html.parser.create();

    try html.parser.init(parser);

    // Parse
    const doc = try html.parser.parse(parser, input, input.len);
    html.parser.destroy(parser);

    const body = html.document.bodyElement(doc);
    _ = body;

    var cur: tag.IdEnum = .LXB_TAG_A;
    const last: tag.IdEnum = .LXB_TAG__LAST_ENTRY;

    while (@intFromEnum(cur) < @intFromEnum(last)) : (cur = @enumFromInt(@intFromEnum(cur) + 1)) {
        const tag_name = try tag.nameById(cur, &tag_name_len);
        // const element = try dom.Document.createElement(&doc.document.dom_document, &tag_name.?[0], tag_name_len, null);
        // const element = try dom.Document.createElement(&doc.document.dom_document, tag_name, tag_name_len, null);
        const element = try dom.document.createElement(&doc.dom_document, tag_name, tag_name_len, null);
        _ = element;

        if (html.tag.isVoid(cur)) {
            // std.debug.print("Create element by tag name \"{s}\"\n", .{tag_name});
        } else {
            // std.debug.print("Create element by tag name \"{s}\" and append text node: ", .{tag_name});
            // lxb_dom_document_create_text_node
        }
    }
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
