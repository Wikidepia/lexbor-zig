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

test "init_null" {
    const status = core.array.init(null, 32);
    try expectEqual(status, .error_object_is_null);
}

test "init_stack" {
    var array: core.Array = undefined;
    const status = core.array.init(&array, 32);

    try expectEqual(status, .ok);

    _ = core.array.destroy(&array, false);
}

test "clean" {
    var array: core.Array = undefined;
    _ = core.array.init(&array, 32);

    _ = core.array.push(&array, @as(*anyopaque, @ptrFromInt(1)));
    try expectEqual(core.array.length(&array), 1);

    core.array.clean(&array);
    try expectEqual(core.array.length(&array), 0);

    _ = core.array.destroy(&array, false);
}

test "push" {
    var array: core.Array = undefined;
    _ = core.array.init(&array, 32);

    try expectEqual(core.array.length(&array), 0);

    _ = core.array.push(&array, @as(*anyopaque, @ptrFromInt(1)));

    try expectEqual(core.array.length(&array), 1);
    try expectEqual(core.array.get(&array, 0), @as(*anyopaque, @ptrFromInt(1)));

    _ = core.array.destroy(&array, false);
}

test "push_null" {
    var array: core.Array = undefined;
    _ = core.array.init(&array, 32);

    _ = core.array.push(&array, null);

    try expectEqual(core.array.length(&array), 1);
    try expectEqual(core.array.get(&array, 0), null);

    _ = core.array.destroy(&array, false);
}

test "pop" {
    var array: core.Array = undefined;
    _ = core.array.init(&array, 32);

    _ = core.array.push(&array, @as(*anyopaque, @ptrFromInt(123)));

    try expectEqual(core.array.pop(&array), @as(*anyopaque, @ptrFromInt(123)));
    try expectEqual(core.array.length(&array), 0);

    _ = core.array.destroy(&array, false);
}

test "pop_if_empty" {
    var array: core.Array = undefined;
    _ = core.array.init(&array, 32);

    try expectEqual(core.array.length(&array), 0);
    try expectEqual(core.array.pop(&array), null);
    try expectEqual(core.array.length(&array), 0);

    _ = core.array.destroy(&array, false);
}

test "get" {
    var array: core.Array = undefined;
    _ = core.array.init(&array, 32);

    try expectEqual(core.array.get(&array, 1), null);
    try expectEqual(core.array.get(&array, 0), null);

    _ = core.array.push(&array, @as(*anyopaque, @ptrFromInt(123)));

    try expectEqual(core.array.get(&array, 0), @as(*anyopaque, @ptrFromInt(123)));
    try expectEqual(core.array.get(&array, 1), null);
    try expectEqual(core.array.get(&array, 1000), null);

    _ = core.array.destroy(&array, false);
}

test "set" {
    var array: core.Array = undefined;
    _ = core.array.init(&array, 32);

    _ = core.array.push(&array, @as(*anyopaque, @ptrFromInt(123)));

    try expectEqual(core.array.set(&array, 0, @as(*anyopaque, @ptrFromInt(456))), .ok);
    try expectEqual(core.array.get(&array, 0), @as(*anyopaque, @ptrFromInt(456)));

    try expectEqual(core.array.length(&array), 1);

    _ = core.array.destroy(&array, false);
}

test "set_not_exists" {
    var array: core.Array = undefined;
    _ = core.array.init(&array, 32);

    try expectEqual(core.array.set(&array, 10, @as(*anyopaque, @ptrFromInt(123))), .ok);
    try expectEqual(core.array.get(&array, 10), @as(*anyopaque, @ptrFromInt(123)));

    for (0..10) |i| {
        try expectEqual(core.array.get(&array, i), null);
    }

    try expectEqual(core.array.length(&array), 11);

    _ = core.array.destroy(&array, false);
}

test "insert" {
    var status: core.Status = undefined;
    var array: core.Array = undefined;
    _ = core.array.init(&array, 32);

    status = core.array.insert(&array, 0, @as(*anyopaque, @ptrFromInt(456)));
    try expectEqual(status, .ok);

    try expectEqual(core.array.get(&array, 0), @as(*anyopaque, @ptrFromInt(456)));

    try expectEqual(core.array.length(&array), 1);
    try expectEqual(core.array.size(&array), 32);

    _ = core.array.destroy(&array, false);
}

test "insert_end" {
    var status: core.Status = undefined;
    var array: core.Array = undefined;
    _ = core.array.init(&array, 32);

    status = core.array.insert(&array, 32, @as(*anyopaque, @ptrFromInt(457)));
    try expectEqual(status, .ok);

    try expectEqual(core.array.get(&array, 32), @as(*anyopaque, @ptrFromInt(457)));

    try expectEqual(core.array.length(&array), 33);
    try expect(core.array.size(&array) != 32);
    _ = core.array.destroy(&array, false);
}

test "insert_overflow" {
    var status: core.Status = undefined;
    var array: core.Array = undefined;
    _ = core.array.init(&array, 32);

    status = core.array.insert(&array, 33, @as(*anyopaque, @ptrFromInt(458)));
    try expectEqual(status, .ok);

    try expectEqual(core.array.get(&array, 33), @as(*anyopaque, @ptrFromInt(458)));

    try expectEqual(core.array.length(&array), 34);
    try expect(core.array.size(&array) != 32);

    _ = core.array.destroy(&array, false);
}

test "insert_to" {
    var status: core.Status = undefined;
    var array: core.Array = undefined;
    _ = core.array.init(&array, 32);

    try expectEqual(core.array.push(&array, @as(*anyopaque, @ptrFromInt(1))), .ok);
    try expectEqual(core.array.push(&array, @as(*anyopaque, @ptrFromInt(2))), .ok);
    try expectEqual(core.array.push(&array, @as(*anyopaque, @ptrFromInt(3))), .ok);
    try expectEqual(core.array.push(&array, @as(*anyopaque, @ptrFromInt(4))), .ok);
    try expectEqual(core.array.push(&array, @as(*anyopaque, @ptrFromInt(5))), .ok);
    try expectEqual(core.array.push(&array, @as(*anyopaque, @ptrFromInt(6))), .ok);
    try expectEqual(core.array.push(&array, @as(*anyopaque, @ptrFromInt(7))), .ok);
    try expectEqual(core.array.push(&array, @as(*anyopaque, @ptrFromInt(8))), .ok);
    try expectEqual(core.array.push(&array, @as(*anyopaque, @ptrFromInt(9))), .ok);

    status = core.array.insert(&array, 4, @as(*anyopaque, @ptrFromInt(459)));
    try expectEqual(status, .ok);

    try expectEqual(core.array.get(&array, 0), @as(*anyopaque, @ptrFromInt(1)));
    try expectEqual(core.array.get(&array, 1), @as(*anyopaque, @ptrFromInt(2)));
    try expectEqual(core.array.get(&array, 2), @as(*anyopaque, @ptrFromInt(3)));
    try expectEqual(core.array.get(&array, 3), @as(*anyopaque, @ptrFromInt(4)));
    try expectEqual(core.array.get(&array, 4), @as(*anyopaque, @ptrFromInt(459)));
    try expectEqual(core.array.get(&array, 5), @as(*anyopaque, @ptrFromInt(5)));
    try expectEqual(core.array.get(&array, 6), @as(*anyopaque, @ptrFromInt(6)));
    try expectEqual(core.array.get(&array, 7), @as(*anyopaque, @ptrFromInt(7)));
    try expectEqual(core.array.get(&array, 8), @as(*anyopaque, @ptrFromInt(8)));
    try expectEqual(core.array.get(&array, 9), @as(*anyopaque, @ptrFromInt(9)));

    try expectEqual(core.array.length(&array), 10);

    _ = core.array.destroy(&array, false);
}

test "insert_to_end" {
    var status: core.Status = undefined;
    var array: core.Array = undefined;
    _ = core.array.init(&array, 9);

    try expectEqual(core.array.push(&array, @as(*anyopaque, @ptrFromInt(1))), .ok);
    try expectEqual(core.array.push(&array, @as(*anyopaque, @ptrFromInt(2))), .ok);
    try expectEqual(core.array.push(&array, @as(*anyopaque, @ptrFromInt(3))), .ok);
    try expectEqual(core.array.push(&array, @as(*anyopaque, @ptrFromInt(4))), .ok);
    try expectEqual(core.array.push(&array, @as(*anyopaque, @ptrFromInt(5))), .ok);
    try expectEqual(core.array.push(&array, @as(*anyopaque, @ptrFromInt(6))), .ok);
    try expectEqual(core.array.push(&array, @as(*anyopaque, @ptrFromInt(7))), .ok);
    try expectEqual(core.array.push(&array, @as(*anyopaque, @ptrFromInt(8))), .ok);
    try expectEqual(core.array.push(&array, @as(*anyopaque, @ptrFromInt(9))), .ok);

    try expectEqual(core.array.length(&array), 9);
    try expectEqual(core.array.size(&array), 9);

    status = core.array.insert(&array, 4, @as(*anyopaque, @ptrFromInt(459)));
    try expectEqual(status, .ok);

    try expectEqual(core.array.get(&array, 0), @as(*anyopaque, @ptrFromInt(1)));
    try expectEqual(core.array.get(&array, 1), @as(*anyopaque, @ptrFromInt(2)));
    try expectEqual(core.array.get(&array, 2), @as(*anyopaque, @ptrFromInt(3)));
    try expectEqual(core.array.get(&array, 3), @as(*anyopaque, @ptrFromInt(4)));
    try expectEqual(core.array.get(&array, 4), @as(*anyopaque, @ptrFromInt(459)));
    try expectEqual(core.array.get(&array, 5), @as(*anyopaque, @ptrFromInt(5)));
    try expectEqual(core.array.get(&array, 6), @as(*anyopaque, @ptrFromInt(6)));
    try expectEqual(core.array.get(&array, 7), @as(*anyopaque, @ptrFromInt(7)));
    try expectEqual(core.array.get(&array, 8), @as(*anyopaque, @ptrFromInt(8)));
    try expectEqual(core.array.get(&array, 9), @as(*anyopaque, @ptrFromInt(9)));

    try expectEqual(core.array.length(&array), 10);
    try expect(core.array.length(&array) != 9);

    _ = core.array.destroy(&array, false);
}

// test "delete" {
//     var array: lb.core.Array = undefined;
//     _ = array.init(32);
//
//     for (0..10) |i| {
//         _ = array.push(@as(?*anyopaque, @ptrFromInt(i)));
//     }
//
//     try expectEqual(array.length, 10);
//
//     array.delete(10, 100);
//     try expectEqual(array.length, 10);
//
//     array.delete(100, 1);
//     try expectEqual(array.length, 10);
//
//     array.delete(100, 0);
//     try expectEqual(array.length, 10);
//
//     for (0..10) |i| {
//         try expectEqual(lb.core.arrayGet(&array, i), @as(?*anyopaque, @ptrFromInt(i)));
//     }
//
//     array.delete(4, 4);
//     try expectEqual(array.length, 6);
//
//     array.delete(4, 0);
//     try expectEqual(array.length, 6);
//
//     array.delete(0, 0);
//     try expectEqual(array.length, 6);
//
//     try expectEqual(lb.core.arrayGet(&array, 0), @as(?*anyopaque, @ptrFromInt(0)));
//     try expectEqual(lb.core.arrayGet(&array, 1), @as(*anyopaque, @ptrFromInt(1)));
//     try expectEqual(lb.core.arrayGet(&array, 2), @as(*anyopaque, @ptrFromInt(2)));
//     try expectEqual(lb.core.arrayGet(&array, 3), @as(*anyopaque, @ptrFromInt(3)));
//     try expectEqual(lb.core.arrayGet(&array, 4), @as(*anyopaque, @ptrFromInt(8)));
//     try expectEqual(lb.core.arrayGet(&array, 5), @as(*anyopaque, @ptrFromInt(9)));
//
//     array.delete(0, 1);
//     try expectEqual(array.length, 5);
//
//     try expectEqual(lb.core.arrayGet(&array, 0), @as(*anyopaque, @ptrFromInt(1)));
//     try expectEqual(lb.core.arrayGet(&array, 1), @as(*anyopaque, @ptrFromInt(2)));
//     try expectEqual(lb.core.arrayGet(&array, 2), @as(*anyopaque, @ptrFromInt(3)));
//     try expectEqual(lb.core.arrayGet(&array, 3), @as(*anyopaque, @ptrFromInt(8)));
//     try expectEqual(lb.core.arrayGet(&array, 4), @as(*anyopaque, @ptrFromInt(9)));
//
//     array.delete(1, 1000);
//     try expectEqual(array.length, 1);
//
//     try expectEqual(lb.core.arrayGet(&array, 0), @as(*anyopaque, @ptrFromInt(1)));
//
//     _ = array.destroy(false);
// }
//
// test "delete_if_empty" {
//     var array: lb.core.Array = undefined;
//     _ = array.init(32);
//
//     array.delete(0, 0);
//     try expectEqual(array.length, 0);
//
//     array.delete(1, 0);
//     try expectEqual(array.length, 0);
//
//     array.delete(1, 1);
//     try expectEqual(array.length, 0);
//
//     array.delete(100, 1);
//     try expectEqual(array.length, 0);
//
//     array.delete(10, 100);
//     try expectEqual(array.length, 0);
//
//     _ = array.destroy(false);
// }
//
// test "expand" {
//     var array: lb.core.Array = undefined;
//     _ = array.init(32);
//
//     try expect(array.expand(128) != null);
//     try expectEqual(array.size, 128);
//
//     _ = array.destroy(false);
// }
//
// test "destroy" {
//     var array = lb.core.Array.create().?;
//     _ = array.init(32);
//
//     try expectEqual(array.destroy(true), null);
//
//     array = lb.core.Array.create().?;
//     _ = array.init(32);
//
//     try expectEqual(array.destroy(false), array);
//     try expectEqual(array.destroy(true), null);
//     try expectEqual(lb.core.Array.destroy(null, false), null);
// }
//
// test "destroy_stack" {
//     var array: lb.core.Array = undefined;
//     _ = array.init(32);
//
//     try expectEqual(array.destroy(false), &array);
// }
