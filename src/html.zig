pub const document = @import("html/document.zig");
pub const Document = document.Document;

pub const encoding = @import("html/encoding.zig");
pub const Entry = encoding.Entry;
pub const Encoding = encoding.Encoding;

pub const parser = @import("html/parser.zig");
pub const parse = parser.parse;

pub const tag = @import("html/tag.zig");
pub const serialize = @import("html/serialize.zig");
pub const interface = @import("html/interface.zig");

pub const element = @import("html/interfaces/element.zig");
