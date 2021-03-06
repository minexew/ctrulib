.arm
.align 4

/* THIS DOES NOT BELONG HERE */
.global getThreadCommandBuffer
.type getThreadCommandBuffer, %function
getThreadCommandBuffer:
	mrc p15, 0, r0, c13, c0, 3
	add r0, #0x80
	bx lr


.global svcControlMemory
.type svcControlMemory, %function
svcControlMemory:
	stmfd sp!, {r0, r4}
	ldr r0, [sp, #0x8]
	ldr r4, [sp, #0x8+0x4]
	svc 0x01
	ldr r2, [sp], #4
	str r1, [r2]
	ldr r4, [sp], #4
	bx lr

.global svcQueryMemory
.type svcQueryMemory, %function
svcQueryMemory:
	stmfd           sp!, {r0,r1,r4-r6}
	svc             2
	ldr             r6, [sp]
	str             r1, [r6]
	str             r2, [r6,#4]
	str             r3, [r6,#8]
	str             r4, [r6,#0xc]
	ldr             r6, [sp,#4]
	str             r5, [r6]
	add             sp, sp, #8
	ldmfd           sp!, {r4-r6}
	bx              lr

.global svcExitProcess
.type svcExitProcess, %function
svcExitProcess:
	svc 0x03
	bx lr

.global svcCreateThread
.type svcCreateThread, %function
svcCreateThread:
	stmfd sp!, {r0, r4}
	ldr r0, [sp, #0x8]
	ldr r4, [sp, #0x8+0x4]
	svc 0x08
	ldr r2, [sp], #4
	str r1, [r2]
	ldr r4, [sp], #4
	bx lr

.global svcExitThread
.type svcExitThread, %function
svcExitThread:
	svc 0x09
	bx lr

.global svcSleepThread
.type svcSleepThread, %function
svcSleepThread:
	svc 0x0A
	bx lr

.global svcCreateMutex
.type svcCreateMutex, %function
svcCreateMutex:
	str r0, [sp, #-4]!
	svc 0x13
	ldr r3, [sp], #4
	str r1, [r3]
	bx lr

.global svcReleaseMutex
.type svcReleaseMutex, %function
svcReleaseMutex:
	svc 0x14
	bx lr

.global svcCreateEvent
.type svcCreateEvent, %function
svcCreateEvent:
	str r0, [sp,#-4]!
	svc 0x17
	ldr r2, [sp], #4
	str r1, [r2]
	bx lr

.global svcSignalEvent
.type svcSignalEvent, %function
svcSignalEvent:
	svc 0x18
	bx lr

.global svcClearEvent
.type svcClearEvent, %function
svcClearEvent:
	svc 0x19
	bx lr
	
.global svcCreateTimer
.type svcCreateTimer, %function
svcCreateTimer:
	str r0, [sp,#-4]!
	svc 0x1A
	ldr r2, [sp], #4
	str r1, [r2]
	bx lr
	
.global svcSetTimer
.type svcSetTimer, %function
svcSetTimer:
	svc 0x1B
	bx lr
	
.global svcCancelTimer
.type svcCancelTimer, %function
svcCancelTimer:
	svc 0x1C
	bx lr
	
.global svcClearTimer
.type svcClearTimer, %function
svcClearTimer:
	svc 0x1D
	bx lr

.global svcCreateMemoryBlock
.type svcCreateMemoryBlock, %function
svcCreateMemoryBlock:
	str r0, [sp, #-4]!
	ldr r0, [sp, #4]
	svc 0x1E
	ldr r2, [sp], #4
	str r1, [r2]
	bx lr

.global svcMapMemoryBlock
.type svcMapMemoryBlock, %function
svcMapMemoryBlock:
	svc 0x1F
	bx lr

.global svcUnmapMemoryBlock
.type svcUnmapMemoryBlock, %function
svcUnmapMemoryBlock:
	svc 0x20
	bx lr

.global svcCreateAddressArbiter
.type svcCreateAddressArbiter, %function
svcCreateAddressArbiter:
	svc 0x21
	bx lr

.global svcArbitrateAddress
.type svcArbitrateAddress, %function
svcArbitrateAddress:
	push {r4,r5}
	add sp, #8
	ldr r5, [sp]
	ldr r4, [sp, #4]
	sub sp, #8
	svc 0x22
	pop {r4,r5}
	bx lr

.global svcCloseHandle
.type svcCloseHandle, %function
svcCloseHandle:
	svc 0x23
	bx lr

.global svcWaitSynchronization
.type svcWaitSynchronization, %function
svcWaitSynchronization:
	svc 0x24
	bx lr

.global svcWaitSynchronizationN
.type svcWaitSynchronizationN, %function
svcWaitSynchronizationN:
	str r5, [sp, #-4]!
	str r4, [sp, #-4]!
	mov r5, r0
	ldr r0, [sp, #0x8]
	ldr r4, [sp, #0x8+0x4]
	svc 0x25
	str r1, [r5]
	ldr r4, [sp], #4
	ldr r5, [sp], #4
	bx lr

.global svcDuplicateHandle
.type svcDuplicateHandle, %function
svcDuplicateHandle:
	str r0, [sp,#-0x4]!
	svc 0x27
	ldr r3, [sp], #4
	str r1, [r3]
	bx lr

.global svcGetSystemTick
.type svcGetSystemTick, %function
svcGetSystemTick:
	svc 0x28
	bx lr

.global svcGetSystemInfo
.type svcGetSystemInfo, %function
svcGetSystemInfo:
	stmfd sp!, {r0, r4}
	svc 0x2A
	ldr r4, [sp], #4
	str r1, [r4]
	str r2, [r4, #4]
	str r3, [r4, #8]
	ldr r4, [sp], #4
	bx lr

.global svcGetProcessInfo
.type svcGetProcessInfo, %function
svcGetProcessInfo:
	stmfd sp!, {r0, r4}
	svc 0x2B
	ldr r4, [sp], #4
	str r1, [r4]
	str r2, [r4, #4]
	ldr r4, [sp], #4
	bx lr

.global svcConnectToPort
.type svcConnectToPort, %function
svcConnectToPort:
	str r0, [sp,#-0x4]!
	svc 0x2D
	ldr r3, [sp], #4
	str r1, [r3]
	bx lr

.global svcSendSyncRequest
.type svcSendSyncRequest, %function
svcSendSyncRequest:
	svc 0x32
	bx lr

.global svcGetProcessId
.type svcGetProcessId, %function
svcGetProcessId:
	str r0, [sp,#-0x4]!
	svc 0x35
	ldr r3, [sp], #4
	str r1, [r3]
	bx lr

.global svcOutputDebugString
.type svcOutputDebugString, %function
svcOutputDebugString:
   str r0, [sp,#-0x4]!
   svc 0x3D
   ldr r2, [sp], #4
   str r1, [r2]
   bx lr

