using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Client
{
    public partial class MenuForm : Form
    {
        public MenuForm()
        {
            InitializeComponent();
        }
        void childForm_Closed(object sender, FormClosedEventArgs e)
        {
            Show();
        }
        private void enterButton_Click(object sender, EventArgs e)
        {
            Hide();
            ChatForm chatForm = new ChatForm();
            chatForm.FormClosed += new FormClosedEventHandler(childForm_Closed);
            chatForm.Show();
        }
    }
}
