using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Game.Utils;

namespace tool2021
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }


        private void button1_Click(object sender, EventArgs e)
        {
            string strSrc = this.textBox1.Text;
            string strKey = this.textBox3.Text;//"nJxPx8^#b*2Wnn^wUzQOxP0Q%C5MI*uE"
            string str1 = DES.Encrypt(strSrc, strKey);
            this.textBox2.Text=str1;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            string strSrc = this.textBox1.Text;
            string strKey = this.textBox3.Text;//"nJxPx8^#b*2Wnn^wUzQOxP0Q%C5MI*uE"
            string str1 = DES.Decrypt(strSrc, strKey);
            this.textBox2.Text = str1;
        }
    }
}
