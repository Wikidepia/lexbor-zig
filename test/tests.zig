const std = @import("std");
const expectEqual = std.testing.expectEqual;
const expectEqualSlices = std.testing.expectEqualSlices;

const lb = @import("lexbor");

test "document_title" {
    const html = "<head><title>  Oh,    my...   </title></head>";
    var status: lb.core.lexbor_status_t = undefined;

    // Initialization
    var doc = lb.Document.init() orelse return error.FailedToInitialize;
    defer doc.deinit();

    // Parse HTML
    status = doc.parse(html);
    try expectEqual(status, .LXB_STATUS_OK);

    // Get title
    if (doc.getTitle()) |title| {
        try expectEqualSlices(u8, "Oh, my...", title);
    }

    // Get raw title
    if (doc.getRawTitle()) |raw_title| {
        try expectEqualSlices(u8, "  Oh,    my...   ", raw_title);
    }

    // Set new title
    status = doc.setTitle("We change title");
    try expectEqual(status, .LXB_STATUS_OK);

    // Get new title
    if (doc.getTitle()) |new_title| {
        try expectEqualSlices(u8, "We change title", new_title);
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
