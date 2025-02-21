const std = @import("std");
const sliceTo = std.mem.sliceTo;

pub const core = @import("../core_ext.zig");
pub const html = @import("../html_ext.zig");
pub const dom = @import("../dom_ext.zig");

pub const errors = @import("../errors.zig");

// const html.lxb_html_document_t = @This();

// document: *html.lxb_html_document_t,

const Error = error{
    FailedToHtmlInitialize,
};

pub fn create() Error!*html.lxb_html_document_t {
    const document = html.lxb_html_document_create() orelse return error.FailedToHtmlInitialize;
    return document;
}

pub fn destroy(document: *html.lxb_html_document_t) void {
    _ = html.lxb_html_document_destroy(document);
}

pub fn parse(document: *html.lxb_html_document_t, input: []const u8) errors.LxbStatusError!void {
    const status = html.lxb_html_document_parse(document, @ptrCast(input.ptr), input.len);
    return errors.maybeLxbStatusError(status);
}

pub fn parseChunkBegin(document: *html.lxb_html_document_t) errors.LxbStatusError!void {
    const status = html.lxb_html_document_parse_chunk_begin(document);
    return errors.maybeLxbStatusError(status);
}

pub fn parseChunk(document: *html.lxb_html_document_t, data: ?*const core.lxb_char_t, size: usize) errors.LxbStatusError!void {
    const status = html.lxb_html_document_parse_chunk(document, data, size);
    return errors.maybeLxbStatusError(status);
}

pub fn parseChunkEnd(document: *html.lxb_html_document_t) errors.LxbStatusError!void {
    const status = html.lxb_html_document_parse_chunk_end(document);
    return errors.maybeLxbStatusError(status);
}

pub fn getTitle(document: *html.lxb_html_document_t) ?[]const u8 {
    var len: usize = undefined;
    const title = html.lxb_html_document_title(document, &len) orelse return null;
    return sliceTo(@as([*:0]u8, @ptrCast(title)), 0);
}

pub fn getRawTitle(document: *html.lxb_html_document_t) ?[]const u8 {
    var len: usize = undefined;
    const raw_title = html.lxb_html_document_title_raw(document, &len) orelse return null;
    return sliceTo(@as([*:0]u8, @ptrCast(raw_title)), 0);
}

pub fn setTitle(document: *html.lxb_html_document_t, new_title: []const u8) errors.LxbStatusError!void {
    const status = html.lxb_html_document_title_set(document, @ptrCast(new_title.ptr), new_title.len);
    return errors.maybeLxbStatusError(status);
}

pub fn bodyElement(document: *html.lxb_html_document_t) ?*html.lxb_html_body_element_t {
    return document.body;
}

// test {
//     @import("std").testing.refAllDeclsRecursive(@This());
// }
