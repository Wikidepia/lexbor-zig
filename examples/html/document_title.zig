const std = @import("std");
const print = std.debug.print;

const serialize = @import("base.zig").serialize;

const dom = @import("lexbor").dom;
const html = @import("lexbor").html;

pub fn main() !void {
    const input = "<head><title>  Oh,    my...   </title></head>";

    // Initialization
    const doc = try html.document.create();
    defer html.document.destroy(doc);

    // Parse HTML
    try html.document.parse(doc, input);

    // Print HTML tree
    print("HTML Tree:\n", .{});
    serialize(dom.interface.node(doc));

    // Get title
    if (html.document.getTitle(doc)) |title| {
        print("\nTitle: {s}", .{title});
    } else {
        print("\nTitle is empty", .{});
    }

    // Get raw title
    if (html.document.getRawTitle(doc)) |raw_title| {
        print("\nRaw title: {s}", .{raw_title});
    } else {
        print("\nRaw title is empty", .{});
    }

    // Set new title
    const new_title = "We change title";
    print("\nChange title to: {s}", .{new_title});
    try html.document.setTitle(doc, new_title);

    // Get new title
    if (html.document.getTitle(doc)) |title| {
        print("\nNew title: {s}", .{title});
    } else {
        print("\nNew title is empty", .{});
    }

    // Print HTML tree
    print("\n\nHTML Tree after change title:\n", .{});
    serialize(dom.interface.node(doc));
}
