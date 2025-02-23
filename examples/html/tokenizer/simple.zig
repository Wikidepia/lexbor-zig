const std = @import("std");
const exit = std.process.exit;
const print = std.debug.print;
const printf = std.c.printf;

const core = @import("lexbor").core;
const html = @import("lexbor").html;
const tag = @import("lexbor").tag;

pub fn main() void {
    var status: core.Status = undefined;
    const data = "<div a='b' enabled> &copy; Hi<span c=\"d\" e=f>" ++
        " my </span>friend</div>";

    print("HTML:\n{s}\n\n", .{data});
    print("Result:\n", .{});

    const tkz = html.tokenizer.create();
    defer _ = html.tokenizer.destroy(tkz);

    status = html.tokenizer.init(tkz);
    if (status != .ok) failed("Failed to create tokenizer object", .{});

    // Set callback for token
    html.tokenizer.callbackTokenDoneSet(tkz, tokenCallback, null);

    status = html.tokenizer.begin(tkz);
    if (status != .ok) failed("Failed to prepare tokenizer object for parsing", .{});

    status = html.tokenizer.chunk(tkz, data, data.len);
    if (status != .ok) failed("Failed to parse the html data", .{});

    status = html.tokenizer.end(tkz);
    if (status != .ok) failed("Failed to ending of parsing the html data", .{});

    print("\n", .{});
}

fn tokenCallback(tkz: ?*html.Tokenizer, token: ?*html.Token, ctx: ?*anyopaque) callconv(.C) ?*html.Token {
    _ = tkz;
    _ = ctx;

    // Last token, end of parsing
    if (@as(tag.IdEnum, @enumFromInt(token.?.tag_id)) == ._end_of_file) return token;

    // Text token
    if (@as(tag.IdEnum, @enumFromInt(token.?.tag_id)) == ._text) {
        _ = printf("%.*s", @intFromPtr(token.?.end) - @intFromPtr(token.?.begin), token.?.begin);
        return token;
    }

    // Tag name
    // if (token.?.type & @intFromEnum(html.token.Type.close) == 1) {
    if (token.?.type & @intFromEnum(html.token.Type.close) == 1) {
        _ = printf("</%.*s", @intFromPtr(token.?.end) - @intFromPtr(token.?.begin), token.?.begin);
    } else {
        _ = printf("<%.*s", @intFromPtr(token.?.end) - @intFromPtr(token.?.begin), token.?.begin);
    }

    // Attributes
    var attr = token.?.attr_first;

    while (attr != null) {
        // Name
        _ = printf(" %.*s", @intFromPtr(attr.?.name_end) - @intFromPtr(attr.?.name_begin), attr.?.name_begin);

        // Value
        if (attr.?.value_begin != null) {
            // Get original quote
            const qo: core.CharType = @as(*core.CharType, @ptrFromInt((@intFromPtr(attr.?.value_begin) - 1))).*;

            // Attribute have no quote
            if (qo == '=') {
                _ = printf("=%.*s", @intFromPtr(attr.?.value_end) - @intFromPtr(attr.?.value_begin), attr.?.value_begin);
            } else {
                _ = printf("=%c%.*s%c", qo, @intFromPtr(attr.?.value_end) - @intFromPtr(attr.?.value_begin), attr.?.value_begin, qo);
            }
        }

        attr = attr.?.next;
    }

    print(">", .{});

    return token;
}

pub fn failed(comptime fmt: []const u8, args: anytype) noreturn {
    print(fmt, args);
    exit(1);
}
