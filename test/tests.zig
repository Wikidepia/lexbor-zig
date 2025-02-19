const std = @import("std");
const expectEqual = std.testing.expectEqual;
const expectEqualSlices = std.testing.expectEqualSlices;

// const Document = @import("lexbor").Document;


test "document_title" {
    const html = "<head><title>  Oh,    my...   </title></head>";

    // Initialization
    // var doc = try .Create();
    // defer lb.documentDestroy(&doc);

    // Parse HTML
    try doc.parse(html);

    // Get title
    if (doc.getTitle()) |title| {
        try expectEqualSlices(u8, "Oh, my...", title);
    }

    // Get raw title
    if (doc.getRawTitle()) |raw_title| {
        try expectEqualSlices(u8, "  Oh,    my...   ", raw_title);
    }

    // Set new title
    try doc.setTitle("We change title");

    // Get new title
    if (doc.getTitle()) |new_title| {
        try expectEqualSlices(u8, "We change title", new_title);
    }

    // Print HTML tree
    // _ = try doc.serialize(.LXB_HTML_SERIALIZE_OPT_UNDEF);
}

test "document_parse_chunk" {
    const html = [_][]const u8{
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
    var doc = try lb.Document.init();
    defer doc.deinit();

    // Parse HTML
    try doc.parseChunkBegin();

    for (html) |h| {
        try doc.parseChunk(&h[0], h.len);
    }

    try doc.parseChunkEnd();

    // Get title
    if (doc.getTitle()) |title| {
        try expectEqualSlices(u8, "HTML chunks parsing", title);
    }

    // Print Result
    // _ = doc.serialize(.LXB_HTML_SERIALIZE_OPT_UNDEF);
}

test "document_create" {

    // // Initialization
    // var doc = lb.Document.init() orelse return error.FailedToInitialize;
    // defer doc.deinit();
    //
    // // Parse HTML
    // status = doc.parseChunkBegin();
    // try expectEqual(status, .LXB_STATUS_OK);
    //
    // for (html) |h| {
    //     status = doc.parseChunk(&h[0], h.len);
    //     try expectEqual(status, .LXB_STATUS_OK);
    // }
    //
    // status = doc.parseChunkEnd();
    // try expectEqual(status, .LXB_STATUS_OK);
    //
    // // Get title
    // if (doc.getTitle()) |title| {
    //     try expectEqualSlices(u8, "HTML chunks parsing", title);
    // }

    // Print Result
    // _ = doc.serialize(.LXB_HTML_SERIALIZE_OPT_UNDEF);
}

// test "document_title" {
//     const html = "<head><title>  Oh,    my...   </title></head>";
//
//     // Initialization
//     var doc = try lb.Document.init();
//     defer doc.deinit();
//
//     // Parse HTML
//     try doc.parse(html);
//
//     // Get title
//     if (doc.getTitle()) |title| {
//         try expectEqualSlices(u8, "Oh, my...", title);
//     }
//
//     // Get raw title
//     if (doc.getRawTitle()) |raw_title| {
//         try expectEqualSlices(u8, "  Oh,    my...   ", raw_title);
//     }
//
//     // Set new title
//     try doc.setTitle("We change title");
//
//     // Get new title
//     if (doc.getTitle()) |new_title| {
//         try expectEqualSlices(u8, "We change title", new_title);
//     }
//
//     // Print HTML tree
//     // _ = try doc.serialize(.LXB_HTML_SERIALIZE_OPT_UNDEF);
// }

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
