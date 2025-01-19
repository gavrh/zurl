const std = @import("std");
const http = std.http;
const heap = std.heap;

const Client = http.Client;
const Headers = []http.Header;
const Uri = std.Uri;
const RequestOptions = Client.RequestOptions;

var gpa_impl = heap.GeneralPurposeAllocator(.{}){};
const gpa = gpa_impl.allocator();

const Req = struct {
    const Self = @This();
    const Allocator = std.mem.Allocator;

    const ReqOptions = struct {
        max: usize,
    };

    allocator: Allocator,
    client: http.Client,
    req_options: ReqOptions,

    pub fn init(allocator: Allocator, req_options: ReqOptions) Self {
        const c = Client{ .allocator = allocator };
        return Self{
            .allocator = allocator,
            .client = c,
            .req_options = req_options,
        };
    }

    pub fn deinit(self: *Self) void {
        self.client.deinit();
    }

    pub fn get(self: *Self, url: []const u8, headers: Headers, options: ReqOptions) ![]u8 {
        const uri = try Uri.parse(url);

        var req = try self.client.open(http.Method.GET, uri, headers, options);
        defer req.deinit();

        try req.send(.{});
        try req.wait();

        const res = try req.reader().readAllAlloc(self.allocator, self.req_options.max);
        return res;
    }
};

pub fn main() !void {
    std.debug.print("zurl@0.1.0\n", .{});

    const url = "http://localhost:420/";

    var req = Req.init(gpa, .{ .max = 1024 });
    defer req.deinit();

    var headers = Headers.init(gpa);
    defer headers.deinit();

    const buf = try req.get(url, headers, .{});
    defer req.allocator.free(buf);

    std.debug.print("{s}", .{buf});
}
