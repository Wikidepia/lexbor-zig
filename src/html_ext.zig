const std = @import("std");

// const lb = @import("lexbor.zig");
const lxb_css_memory_t = @import("./css_ext.zig").lxb_css_memory_t;
const lxb_css_selectors_t = @import("./css_ext.zig").lxb_css_selectors_t;
const lxb_css_parser_t = @import("./css_ext.zig").lxb_css_parser_t;

// html/interfaces/document.h

pub const lxb_html_document_done_cb_f = ?*const fn (document: ?*lxb_html_document_t) callconv(.C) lxb_status_t;

pub const lxb_html_document_opt_t = c_uint;

pub const lxb_html_document_ready_state_t = enum(c_int) {
    LXB_HTML_DOCUMENT_READY_STATE_UNDEF       = 0x00,
    LXB_HTML_DOCUMENT_READY_STATE_LOADING     = 0x01,
    LXB_HTML_DOCUMENT_READY_STATE_INTERACTIVE = 0x02,
    LXB_HTML_DOCUMENT_READY_STATE_COMPLETE    = 0x03,
};

pub const lxb_html_document_opt = enum(c_int) {
    LXB_HTML_DOCUMENT_OPT_UNDEF     = 0x00,
    LXB_HTML_DOCUMENT_PARSE_WO_COPY = 0x01,
};

pub const lxb_html_document_css_t = extern struct {
    memory: ?*lxb_css_memory_t,
    css_selectors: ?*lxb_css_selectors_t,
    // TODO
    parser: ?*lxb_css_parser_t,
};
