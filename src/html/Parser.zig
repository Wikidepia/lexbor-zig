const std = @import("std");
// const sliceTo = std.mem.sliceTo;

pub const core = @import("../core_ext.zig");
pub const html = @import("../html_ext.zig");
pub const dom = @import("../dom_ext.zig");
pub const Document = @import("Document.zig");

pub const errors = @import("../errors.zig");

const Parser = @This();

parser: *html.lxb_html_parser_t,

const Error = error{
    FailedToInitialize,
    FailedToParse,
};

pub fn create() Error!Parser {
    const parser = html.lxb_html_parser_create() orelse return error.FailedToInitialize;
    return Parser{
        .parser = parser,
    };
}

pub fn init(self: *Parser) errors.LxbStatusError!void {
    const status = html.lxb_html_parser_init(self.parser);
    return errors.maybeLxbStatusError(status);
}

pub fn destroy(self: *Parser) void {
    _ = html.lxb_html_parser_destroy(self.parser);
}

pub fn parse(self: *Parser, input: []const u8, size: usize) Error!Document {
    const document = html.lxb_html_parse(self.parser, @ptrCast(input.ptr), size) orelse return error.FailedToParse;
    return Document{
        .document = document,
    };
}
