const std = @import("std");

pub fn main() !void {
    const page_allocator = std.heap.page_allocator;

    // Initialize the ArenaAllocator, providing the page_allocator as the source of memory.
    var arena = std.heap.ArenaAllocator.init(page_allocator);
    defer arena.deinit(); // Deinitialize the arena when done, freeing all its memory.
    const arena_allocator = arena.allocator(); // Get the actual allocator interface.

    // Now you can use 'arena_allocator' to allocate memory for your data structures.
    const num_items = 10;
    var items = try arena_allocator.alloc(i32, num_items);
    defer arena_allocator.free(items); // Technically not needed here as arena.deinit() frees all.

    for (items, 0..) |_, i| {
        items[i] = @intCast(i * 2);
    }

    std.debug.print("Allocated items from arena: {any}\n", .{items});

    // You can allocate other data structures from the same arena.
    const source = "Hello from the arena!";
    const message = try arena_allocator.alloc(u8, source.len);
    defer arena_allocator.free(message); // Not strictly needed here either.

    std.mem.copyForwards(u8, message, source); // Corrected to copyForwards
    std.debug.print("Message from arena: {s}\n", .{message});
    // When arena.deinit() is called at the end of main, all memory allocated
    // through arena_allocator will be freed in one go.
}

// const std = @import("std");

// pub fn main() !void {
//     const page_allocator = std.heap.page_allocator;

//     // Initialize the ArenaAllocator, providing the page_allocator as the source of memory.
//     var arena = std.heap.ArenaAllocator.init(page_allocator);
//     defer arena.deinit(); // Deinitialize the arena when done, freeing all its memory.
//     const arena_allocator = arena.allocator(); // Get the actual allocator interface.

//     // Now you can use 'arena_allocator' to allocate memory for your data structures.
//     const num_items = 10;
//     var items = try arena_allocator.alloc(i32, num_items);
//     defer arena_allocator.free(items); // Technically not needed here as arena.deinit() frees all.

//     for (items, 0..) |_, i| {
//         items[i] = @intCast(i * 2);
//     }

//     std.debug.print("Allocated items from arena: {any}\n", .{items});

//     // You can allocate other data structures from the same arena.
//     const message = try arena_allocator.alloc(u8, 32);
//     defer arena_allocator.free(message); // Not strictly needed here either.
//     const source = "Hello from the arena!";

//     std.mem.copyForwards(u8, message, source); // Corrected to copyForwards
//     message[source.len] = 0; // Null-terminate the string
//     //std.debug.print("Message from arena: {s}\n", .{message});
//     std.debug.print("Message from arena: {s}\n", .{message[0..source.len]});
//     // When arena.deinit() is called at the end of main, all memory allocated
//     // through arena_allocator will be freed in one go.
// }
