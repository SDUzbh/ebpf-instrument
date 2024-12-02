	.text
	.file	"ebpf.c"
	.section	"tp/syscalls/sys_enter_write","ax",@progbits
	.globl	handle_tp                       # -- Begin function handle_tp
	.p2align	3
	.type	handle_tp,@function
handle_tp:                              # @handle_tp
# %bb.0:
	*(u64 *)(r10 - 8) = r1
	#position0
	r1 = bpf_get_current_pid_tgid ll
	r1 = *(u64 *)(r1 + 0)
	#position1
	callx r1

	r0 >>= 32
	*(u32 *)(r10 - 12) = r0
	#position2
	r1 = 667236
	*(u32 *)(r10 - 16) = r1
	#position3
	r1 = 2675213260325678447 ll
	*(u64 *)(r10 - 24) = r1
	#position4
	r1 = 8243311788065124983 ll
	*(u64 *)(r10 - 32) = r1
	#position5
	r1 = 6877671131690917747 ll
	*(u64 *)(r10 - 40) = r1
	#position6
	r1 = 8751374116481820007 ll
	*(u64 *)(r10 - 48) = r1
	#position7
	r1 = 7451612901544448066 ll
	*(u64 *)(r10 - 56) = r1
	#position8
	r1 = bpf_trace_printk ll
	r4 = *(u64 *)(r1 + 0)
	#position9
	r3 = *(u32 *)(r10 - 12)
	#position10
	r1 = r10
	r1 += -56
	r2 = 44
	callx r4
	*(u64 *)(r10 - 64) = r0
	#position11
	r0 = 0
	exit
.Lfunc_end0:
	.size	handle_tp, .Lfunc_end0-handle_tp
                                        # -- End function
	.type	pid_filter,@object              # @pid_filter
	.section	.rodata,"a",@progbits
	.globl	pid_filter
	.p2align	2, 0x0
pid_filter:
	.long	0                               # 0x0
	.size	pid_filter, 4

	.type	LICENSE,@object                 # @LICENSE
	.section	license,"aw",@progbits
	.globl	LICENSE
LICENSE:
	.asciz	"Dual BSD/GPL"
	.size	LICENSE, 13

	.type	bpf_get_current_pid_tgid,@object # @bpf_get_current_pid_tgid
	.data
	.p2align	3, 0x0
bpf_get_current_pid_tgid:
	.quad	14
	.size	bpf_get_current_pid_tgid, 8

	.type	.L__const.handle_tp.____fmt,@object # @__const.handle_tp.____fmt
	.section	.rodata.str1.1,"aMS",@progbits,1
.L__const.handle_tp.____fmt:
	.asciz	"BPF triggered sys_enter_write from PID %d.\n"
	.size	.L__const.handle_tp.____fmt, 44

	.type	bpf_trace_printk,@object        # @bpf_trace_printk
	.data
	.p2align	3, 0x0
bpf_trace_printk:
	.quad	6
	.size	bpf_trace_printk, 8

	.addrsig
	.addrsig_sym handle_tp
	.addrsig_sym LICENSE
	.addrsig_sym bpf_get_current_pid_tgid
	.addrsig_sym bpf_trace_printk
