const std = @import("std");
const expectEqual = std.testing.expectEqual;

const lb = @import("lexbor");

pub fn main() !void {
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
        std.debug.print("Title: {s}\n", .{title});
    }

    // Get raw title
    if (doc.getRawTitle()) |raw_title| {
        std.debug.print("Raw Title: {s}\n", .{raw_title});
    }

    // Set new title
    status = doc.setTitle(&"We change title"[0], "We change title".len);
    try expectEqual(status, .LXB_STATUS_OK);

    // Get new title
    if (doc.getTitle()) |new_title| {
        std.debug.print("New Title: {s}\n", .{new_title});
    }
}
