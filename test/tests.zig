const std = @import("std");
const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;

const lb = @import("lexbor");

test "init" {
    // const html = "<head><title>  Oh,    <span>my...</span>   </title></head>";
    const html = "<head><title>  Oh,    my...   </title></head>";

    var doc = lb.Document.init() orelse return error.FailedToInitialize;

    const status = doc.parse(html);
    try expectEqual(status, .LXB_STATUS_OK);

    const title = doc.select(.title).innerText().?;

    std.debug.print("title: {s}\n", .{title});
    std.debug.print("title.len: {d}\n", .{title.len});
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
