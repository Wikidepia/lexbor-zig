// src/lexbor.zig

const std = @import("std");
const sliceTo = std.mem.sliceTo;

pub const core = @import("core_ext.zig");
pub const html = @import("html_ext.zig");
// const dom = @import("dom_ext.zig");

pub const Tags = enum {
    __undef,
    title,
};

pub const Document = struct {
    document: *html.lxb_html_document_t,
    cur_tag: Tags,

    pub fn init() ?Document {
        const document = html.lxb_html_document_create() orelse return null;
        return Document{
            .document = document,
            .cur_tag = .__undef,
        };
    }

    pub fn parse(self: Document, doc: []const u8) core.lexbor_status_t {
        const status = html.lxb_html_document_parse(self.document, &doc[0], doc.len);
        return @enumFromInt(status);
    }

    pub fn select(self: *Document, tag: Tags) Document {
        switch (tag) {
            .title => self.cur_tag = .title,
            else => unreachable,
        }
        return self.*;
    }

    pub fn innerText(self: Document) ?[]const u8 {
        var len: usize = undefined;
        const result = switch (self.cur_tag) {
            .title => html.lxb_html_document_title(self.document, &len) orelse return null,
            else => unreachable,
        };
        // return std.mem.sliceTo(@as([*:0]u8, @ptrCast(title_)), len);
        return sliceTo(@as([*:0]u8, @ptrCast(result)), 0);
    }

    // else => {
    //     std.debug.print("Not found tag: {any}\n", .{self.cur_tag});
    //     std.process.exit(1);
    // },

    // pub fn deinit(x: f32, y: f32) Vector2 {
    //     return Vector2{ .x = x, .y = y };
    // }
};

// void main() {
// // This is a valid html document, by the way.
// string html = "<html><body>Hello, world!";
//
// // Parserino can handle it.
// Document doc = Document(html);
// writeln("Document before edit: ", doc);
//
// // Let's change the text inside the body tag.
// doc.body.innerText = "Hello, Parserino!";
// writeln(" Document after edit: ", doc);
// }

// test {
//     @import("std").testing.refAllDeclsRecursive(@This());
// }
