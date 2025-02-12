const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "template",
        .target = target,
        .optimize = optimize,
    });

    exe.addCSourceFiles(.{
        .root = b.path("src"),
        .files = &.{
            "main.c",
        },
    });

    exe.linkLibC();
    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run app");
    run_step.dependOn(&run_cmd.step);
}
