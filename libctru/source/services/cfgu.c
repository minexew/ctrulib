#include <stdlib.h>
#include <3ds.h>

static Handle CFGU_handle = 0;

Result initCfgu()
{
    return srvGetServiceHandle(&CFGU_handle, "cfg:u");
}

Result exitCfgu()
{
    Result ret = svcCloseHandle(CFGU_handle);
    CFGU_handle = 0;

    return ret;
}

Result CFGU_GetRegionCanadaUSA(u8* value)
{
    Result ret = 0;
    u32 *cmdbuf = getThreadCommandBuffer();

    cmdbuf[0] = 0x00040000;

    if((ret = svcSendSyncRequest(CFGU_handle))!=0)return ret;

    *value = (u8)cmdbuf[2];

    return (Result)cmdbuf[1];
}

Result CFGU_GetSystemModel(u8* model)
{
    Result ret = 0;
    u32 *cmdbuf = getThreadCommandBuffer();

    cmdbuf[0] = 0x00050000;

    if((ret = svcSendSyncRequest(CFGU_handle))!=0)return ret;

    *model = (u8)cmdbuf[2];

    return (Result)cmdbuf[1];
}

Result CFGU_GetModelNintendo2DS(u8* value)
{
    Result ret = 0;
    u32 *cmdbuf = getThreadCommandBuffer();

    cmdbuf[0] = 0x00060000;

    if((ret = svcSendSyncRequest(CFGU_handle))!=0)return ret;

    *value = (u8)cmdbuf[2];

    return (Result)cmdbuf[1];
}

Result CFGU_GetCountryCodeString(u16 code, u16* string)
{
    Result ret = 0;
    u32 *cmdbuf = getThreadCommandBuffer();

    cmdbuf[0] = 0x00090040;
    cmdbuf[1] = (u32)code;

    if((ret = svcSendSyncRequest(CFGU_handle))!=0)return ret;

    *string = (u16)cmdbuf[2];

    return (Result)cmdbuf[1];
}

Result CFGU_GetCountryCodeID(u16 string, u16* code)
{
    Result ret = 0;
    u32 *cmdbuf = getThreadCommandBuffer();

    cmdbuf[0] = 0x000A0040;
    cmdbuf[1] = (u32)string;

    if((ret = svcSendSyncRequest(CFGU_handle))!=0)return ret;

    *code = (u16)cmdbuf[2];

    return (Result)cmdbuf[1];
}
