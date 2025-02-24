const std = @import("std");
const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;

const core = @import("lexbor").core;

test "init" {
    const array = core.array.create().?;
    const status = core.array.init(array, 32);

    try expectEqual(status, .ok);

    _ = core.array.destroy(array, true);
}
