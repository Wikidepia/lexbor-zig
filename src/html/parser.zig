pub const core = @import("../core_ext.zig");
pub const html = @import("../html_ext.zig");

pub fn create() ?*html.lxb_html_parser_t {
    return html.lxb_html_parser_create();
}

pub fn init(parser: ?*html.lxb_html_parser_t) core.lexbor_status_t {
    const status = html.lxb_html_parser_init(parser);
    return @enumFromInt(status);
}

pub fn destroy(parser: ?*html.lxb_html_parser_t) ?*html.lxb_html_parser_t {
    return html.lxb_html_parser_destroy(parser);
}

pub fn parse(parser: ?*html.lxb_html_parser_t, input: []const u8, size: usize) ?*html.lxb_html_document_t {
    return html.lxb_html_parse(parser, @ptrCast(input.ptr), size);
}
