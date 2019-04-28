using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Net;
using System.Net.Sockets;
using System.Threading;

namespace Client
{
    public partial class ChatForm : Form
    {
        private Thread thread; // 통신을 위한 쓰레드
        private TcpClient tcpClient;// TCP 클라이언트
        private NetworkStream stream;
        
        private bool threading;

        public ChatForm()
        {
            InitializeComponent();
        }
        /* 서버로부터 메시지를 전달 받습니다. */
        private void read()
        {
            while (true)
            {
                byte[] buf = new byte[1024];
                int bufBytes = stream.Read(buf, 0, buf.Length);
                string message = Encoding.ASCII.GetString(buf, 0, bufBytes);

                /* 방 접속 성공 (메시지: [Enter]) */
                if (message.Contains("[Enter]"))
                {
                    this.contentText.AppendText("[알람]어서오세요.\n");
                }
 
                /* 상대방이 나간 경우 (메시지: [Exit]) */
                if (message.Contains("[Exit]"))
                {
                    this.contentText.AppendText("상대방이 나갔습니다.\n");
                }
                /* chat content */
                if (message.Contains("[Put]"))
                {
                    string chat = message.Split(']')[1];
                    
                    this.contentText.AppendText(chat);
                }
            }
        }
        private void inputButton_Click(object sender, EventArgs e)
        {
            string message;
            byte[] buf;
            if (threading == false)
            {
                tcpClient = new TcpClient();
                tcpClient.Connect("127.0.0.1", 9876);
                stream = tcpClient.GetStream();

                thread = new Thread(new ThreadStart(read));
                thread.Start();
                threading = true;

                /* 방 접속 진행하기 */
                message = "[Enter]";
                buf = Encoding.ASCII.GetBytes(message);
                stream.Write(buf, 0, buf.Length);

                /*버튼 명 변경*/
                this.inputButton.Text = "입력";
            }
            else
            {
                /* 메지시보내기 */
                message = "[Put]";
                buf = Encoding.ASCII.GetBytes(message + this.textBox.Text + "\n");
                stream.Write(buf, 0, buf.Length);

                /*text box clear*/
                this.textBox.Clear();
            }
        }
        private void ChatForm_FormClosed(object sender, FormClosedEventArgs e)
        {
            closeNetwork();
        }
        void closeNetwork()
        {
            if (threading && thread.IsAlive)
                thread.Abort();
            tcpClient.Close();
        }
    }
}
