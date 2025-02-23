pub const array = @import("core/array.zig");
pub const Array = array.Array;

const base = @import("core/base.zig");
pub const VERSION_MAJOR = base.VERSION_MAJOR;
pub const VERSION_MINOR = base.VERSION_MINOR;
pub const VERSION_PATCH = base.VERSION_PATCH;
pub const VERSION_STRING = base.VERSION_STRING;
pub const max = base.max;
pub const min = base.min;
pub const Status = base.Status;
pub const Action = base.Action;
pub const SerializeCbF = base.serializeCbF;
pub const SerializeCbCpF = base.serializeCbCpF;
pub const SerializeCtx = base.serializeCtx;

pub const fs = @import("core/fs.zig");

const types = @import("core/types.zig");
pub const CodepointType = types.CodepointType;
pub const StatusType = types.StatusType;
pub const CharType = types.CharType;
pub const CallbackF = types.CallbackF;

const lexbor = @import("core/lexbor.zig");
pub const MemoryMallocF = lexbor.MemoryMallocF;
pub const MemoryReallocF = lexbor.MemoryReallocF;
pub const MemoryCallocF = lexbor.MemoryCallocF;
pub const MemoryFreeF = lexbor.MemoryFreeF;
pub const malloc = lexbor.malloc;
pub const realloc = lexbor.realloc;
pub const calloc = lexbor.calloc;
pub const free = lexbor.free;
