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
    // return html.lxb_html_document_t{
    //     .document = document,
    // };
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

pub fn serialize(document: *html.lxb_html_document_t, opt: html.lxb_html_serialize_opt) errors.LxbStatusError!void {
    const node = @as(?*dom.lxb_dom_node_t, @ptrCast(document));
    const status = html.lxb_html_serialize_pretty_tree_cb(node, @intFromEnum(opt), 0, serializer_callback, null);
    return errors.maybeLxbStatusError(status);
}

pub fn bodyElement(document: *html.lxb_html_document_t) ?*html.lxb_html_body_element_t {
    return document.body;
}

fn serializer_callback(data: ?[*:0]const core.lxb_char_t, len: usize, ctx: ?*anyopaque) callconv(.C) core.lxb_status_t {
    _ = ctx;
    _ = len;
    std.debug.print("{s}", .{data.?});
    return @intFromEnum(core.lexbor_status_t.LXB_STATUS_OK);
}

// test {
//     @import("std").testing.refAllDeclsRecursive(@This());
// }

// const result: errors.LxbStatusError!void = switch (@as(core.lexbor_status_t, @enumFromInt(status))) {
//     .LXB_STATUS_ERROR => .Error,
//     .LXB_STATUS_ERROR_MEMORY_ALLOCATION => .MemoryAllocation,
//     .LXB_STATUS_ERROR_OBJECT_IS_NULL => .ObjectIsNull,
//     .LXB_STATUS_ERROR_SMALL_BUFFER => .SmallBuffer,
//     .LXB_STATUS_ERROR_INCOMPLETE_OBJECT => .IncompleteObject,
//     .LXB_STATUS_ERROR_NO_FREE_SLOT => .NoFreeSlot,
//     .LXB_STATUS_ERROR_TOO_SMALL_SIZE => .TooSmallSize,
//     .LXB_STATUS_ERROR_NOT_EXISTS => .NotExists,
//     .LXB_STATUS_ERROR_WRONG_ARGS => .WrongArgs,
//     .LXB_STATUS_ERROR_WRONG_STAGE => .WrongStage,
//     .LXB_STATUS_ERROR_UNEXPECTED_RESULT => .UnexpectedResult,
//     .LXB_STATUS_ERROR_UNEXPECTED_DATA => .UnexpectedData,
//     .LXB_STATUS_ERROR_OVERFLOW => .Overflow,
//     else => {},
// };
// return result;
