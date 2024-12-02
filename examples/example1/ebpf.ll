; ModuleID = 'ebpf.c'
source_filename = "ebpf.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

@pid_filter = dso_local local_unnamed_addr constant i32 0, align 4
@LICENSE = dso_local global [13 x i8] c"Dual BSD/GPL\00", section "license", align 1
@__const.handle_tp.____fmt = private unnamed_addr constant [44 x i8] c"BPF triggered sys_enter_write from PID %d.\0A\00", align 1
@llvm.compiler.used = appending global [2 x ptr] [ptr @LICENSE, ptr @handle_tp], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @handle_tp(ptr nocapture readnone %0) #0 section "tp/syscalls/sys_enter_write" {
  %2 = alloca [44 x i8], align 1
  %3 = tail call i64 inttoptr (i64 14 to ptr)() #3
  %4 = lshr i64 %3, 32
  %5 = trunc i64 %4 to i32
  call void @llvm.lifetime.start.p0(i64 44, ptr nonnull %2) #3
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(44) %2, ptr noundef nonnull align 1 dereferenceable(44) @__const.handle_tp.____fmt, i64 44, i1 false)
  %6 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull %2, i32 noundef 44, i32 noundef %5) #3
  call void @llvm.lifetime.end.p0(i64 44, ptr nonnull %2) #3
  ret i32 0
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

attributes #0 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"frame-pointer", i32 2}
!2 = !{!"Ubuntu clang version 16.0.6 (23ubuntu4)"}
