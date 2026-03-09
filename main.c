#include <3ds.h>

int main()
{
    aptInit();

    u64 titleID = 0x000400000DEAD100ULL; // CTR Bricker TitleID
    APT_DoApplicationJump(0, titleID, 0);

    aptExit();
    return 0;
}