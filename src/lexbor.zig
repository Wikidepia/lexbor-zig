// src/lexbor.zig

const std = @import("std");
const sliceTo = std.mem.sliceTo;

pub const core = @import("core_ext.zig");
pub const html = @import("html_ext.zig");
pub const dom = @import("dom_ext.zig");

pub const Parser = struct {};

const GeneralError = error{
    Error,
    MemoryAllocation,
    ObjectIsNull,
    SmallBuffer,
    IncompleteObject,
    NoFreeSlot,
    TooSmallSize,
    NotExists,
    WrongArgs,
    WrongStage,
    UnexpectedResult,
    UnexpectedData,
    Overflow,
};

const DocumentError = error{
    FailedToInitialize,
};

fn maybeError(status: core.lxb_status_t) GeneralError!void {
    return switch (@as(core.lexbor_status_t, @enumFromInt(status))) {
        .LXB_STATUS_ERROR => error.Error,
        .LXB_STATUS_ERROR_MEMORY_ALLOCATION => error.MemoryAllocation,
        .LXB_STATUS_ERROR_OBJECT_IS_NULL => error.ObjectIsNull,
        .LXB_STATUS_ERROR_SMALL_BUFFER => error.SmallBuffer,
        .LXB_STATUS_ERROR_INCOMPLETE_OBJECT => error.IncompleteObject,
        .LXB_STATUS_ERROR_NO_FREE_SLOT => error.NoFreeSlot,
        .LXB_STATUS_ERROR_TOO_SMALL_SIZE => error.TooSmallSize,
        .LXB_STATUS_ERROR_NOT_EXISTS => error.NotExists,
        .LXB_STATUS_ERROR_WRONG_ARGS => error.WrongArgs,
        .LXB_STATUS_ERROR_WRONG_STAGE => error.WrongStage,
        .LXB_STATUS_ERROR_UNEXPECTED_RESULT => error.UnexpectedResult,
        .LXB_STATUS_ERROR_UNEXPECTED_DATA => error.UnexpectedData,
        .LXB_STATUS_ERROR_OVERFLOW => error.Overflow,
        else => {},
    };
}

pub const Document = struct {
    document: *html.lxb_html_document_t,

    pub fn init() DocumentError!Document {
        const document = html.lxb_html_document_create() orelse return error.FailedToInitialize;
        return Document{
            .document = document,
        };
    }

    pub fn deinit(self: *Document) void {
        _ = html.lxb_html_document_destroy(self.document);
    }

    pub fn parse(self: Document, doc: []const u8) GeneralError!void {
        const status = html.lxb_html_document_parse(self.document, &doc[0], doc.len);
        return maybeError(status);
    }

    pub fn parseChunkBegin(self: Document) GeneralError!void {
        const status = html.lxb_html_document_parse_chunk_begin(self.document);
        return maybeError(status);
    }

    pub fn parseChunk(self: Document, data: ?*const core.lxb_char_t, size: usize) GeneralError!void {
        const status = html.lxb_html_document_parse_chunk(self.document, data, size);
        return maybeError(status);
    }

    pub fn parseChunkEnd(self: Document) GeneralError!void {
        const status = html.lxb_html_document_parse_chunk_end(self.document);
        return maybeError(status);
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

    pub fn setTitle(self: *Document, new_title: []const u8) GeneralError!void {
        const status = html.lxb_html_document_title_set(self.document, &new_title[0], new_title.len);
        return maybeError(status);
    }

    pub fn serialize(self: Document, opt: html.lxb_html_serialize_opt) GeneralError!void {
        const node = @as(?*dom.lxb_dom_node_t, @ptrCast(self.document));
        const status = html.lxb_html_serialize_pretty_tree_cb(node, @intFromEnum(opt), 0, serializer_callback, null);
        return maybeError(status);
    }

    fn serializer_callback(data: ?[*:0]const core.lxb_char_t, len: usize, ctx: ?*anyopaque) callconv(.C) core.lxb_status_t {
        _ = ctx;
        _ = len;
        std.debug.print("{s}", .{data.?});
        return @intFromEnum(core.lexbor_status_t.LXB_STATUS_OK);
    }
};

// std.debug.print("{any}\n", .{});

// test {
//     @import("std").testing.refAllDeclsRecursive(@This());
// }

// const result: GeneralError!void = switch (@as(core.lexbor_status_t, @enumFromInt(status))) {
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
