// src/lexbor.zig

const std = @import("std");
const sliceTo = std.mem.sliceTo;

pub const core = @import("core_ext.zig");
pub const html = @import("html_ext.zig");
// const dom = @import("dom_ext.zig");

pub const Document = struct {
    document: *html.lxb_html_document_t,

    pub fn init() ?Document {
        const document = html.lxb_html_document_create() orelse return null;
        return Document{
            .document = document,
        };
    }

    pub fn deinit(self: *Document) void {
        _ = html.lxb_html_document_destroy(self.document);
    }

    pub fn parse(self: Document, doc: []const u8) core.lexbor_status_t {
        const status = html.lxb_html_document_parse(self.document, &doc[0], doc.len);
        return @enumFromInt(status);
    }

    pub fn getTitle(self: Document) ?[]const u8 {
        var len: usize = undefined;
        const title = html.lxb_html_document_title(self.document, &len) orelse return null;
        return sliceTo(@as([*:0]u8, @ptrCast(title)), 0);
    }

    pub fn getRawTitle(self: Document) ?[]const u8 {
        var len: usize = undefined;
        const raw_title = html.lxb_html_document_title_raw(self.document, &len) orelse return null;
        return sliceTo(@as([*:0]u8, @ptrCast(raw_title)), 0);
    }

    pub fn setTitle(self: *Document, new_title: []const u8) core.lexbor_status_t {
        const status = html.lxb_html_document_title_set(self.document, &new_title[0], new_title.len);
        return @enumFromInt(status);
    }
};

// std.debug.print("{any}\n", .{});

// test {
//     @import("std").testing.refAllDeclsRecursive(@This());
// }
