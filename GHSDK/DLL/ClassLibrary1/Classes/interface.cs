using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;

namespace Ghadir_UI
{
    public interface IOInterface
    {

        void SendToClient(ArrayList Buffer);
        ArrayList ReceiveFromClient();

    }
}
