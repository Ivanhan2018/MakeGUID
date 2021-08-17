using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
using System.IO;
using System.Text;
using System.Security.Cryptography;
using System.Security.Permissions;

namespace tool2021
{
	/// <summary>
	/// Form1 的摘要说明。
	/// </summary>
	public class Form1 : System.Windows.Forms.Form
	{
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.TextBox textBox1;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.TextBox textBox2;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.TextBox textBox3;
		private System.Windows.Forms.Button button1;
		private System.Windows.Forms.Button button2;
		private System.Windows.Forms.Button button3;
		private System.Windows.Forms.Button button4;
		private System.Windows.Forms.Button button5;
		/// <summary>
		/// 必需的设计器变量。
		/// </summary>
		private System.ComponentModel.Container components = null;

		//
		// Static Methods
		//
		public static string HPDecrypt (string Text, string sKey)
		{
			DESCryptoServiceProvider dESCryptoServiceProvider = new DESCryptoServiceProvider ();
			int num = Text.Length / 2;
			byte[] array = new byte[num];
			for (int i = 0; i < num; i++)
			{
				int num2 = Convert.ToInt32 (Text.Substring (i * 2, 2), 16);
				array [i] = (byte)num2;
			}
			dESCryptoServiceProvider.Key = Encoding.ASCII.GetBytes (HashPasswordForStoringInConfigFile (sKey, "md5").Substring (0, 8));
			dESCryptoServiceProvider.IV = Encoding.ASCII.GetBytes (HashPasswordForStoringInConfigFile (sKey, "md5").Substring (0, 8));
			MemoryStream memoryStream = new MemoryStream ();
			CryptoStream cryptoStream = new CryptoStream (memoryStream, dESCryptoServiceProvider.CreateDecryptor (), CryptoStreamMode.Write);
			cryptoStream.Write (array, 0, array.Length);
			cryptoStream.FlushFinalBlock ();
			return Encoding.Default.GetString (memoryStream.ToArray ());
		}

		public static string HPEncrypt (string Text, string sKey)
		{
			DESCryptoServiceProvider dESCryptoServiceProvider = new DESCryptoServiceProvider ();
			byte[] bytes = Encoding.Default.GetBytes (Text);
			dESCryptoServiceProvider.Key = Encoding.ASCII.GetBytes (HashPasswordForStoringInConfigFile (sKey, "md5").Substring (0, 8));
			dESCryptoServiceProvider.IV = Encoding.ASCII.GetBytes (HashPasswordForStoringInConfigFile (sKey, "md5").Substring (0, 8));
			MemoryStream memoryStream = new MemoryStream ();
			CryptoStream cryptoStream = new CryptoStream (memoryStream, dESCryptoServiceProvider.CreateEncryptor (), CryptoStreamMode.Write);
			cryptoStream.Write (bytes, 0, bytes.Length);
			cryptoStream.FlushFinalBlock ();
			StringBuilder stringBuilder = new StringBuilder ();
			byte[] array = memoryStream.ToArray ();
			for (int i = 0; i < array.Length; i++)
			{
				byte b = array [i];
				stringBuilder.AppendFormat ("{0:X2}", b);
			}
			return stringBuilder.ToString ();
		}

		//
		// Static Methods
		//
		public static string Decrypt (string decryptString, string decryptKey)
		{
			string result;
			try
			{
				decryptKey = CutLeft (decryptKey, 8);
				decryptKey = decryptKey.PadRight (8, ' ');
				byte[] bytes = Encoding.UTF8.GetBytes (decryptKey);
				byte[] keys =  new byte[]
				{
					18,
					52,
					86,
					120,
					144,
					171,
					205,
					239
				};
				byte[] array = Convert.FromBase64String (decryptString);
				DESCryptoServiceProvider dESCryptoServiceProvider = new DESCryptoServiceProvider ();
				MemoryStream memoryStream = new MemoryStream ();
				CryptoStream cryptoStream = new CryptoStream (memoryStream, dESCryptoServiceProvider.CreateDecryptor (bytes, keys), CryptoStreamMode.Write);
				cryptoStream.Write (array, 0, array.Length);
				cryptoStream.FlushFinalBlock ();
				result = Encoding.UTF8.GetString (memoryStream.ToArray ());
			}
			catch
			{
				result = "";
			}
			return result;
		}

		public static string Encrypt (string encryptString, string encryptKey)
		{
			encryptKey = CutLeft (encryptKey, 8);
			encryptKey = encryptKey.PadRight (8, ' ');
			byte[] bytes = Encoding.UTF8.GetBytes (encryptKey.Substring (0, 8));
			byte[] keys =  new byte[]
			{
				18,
				52,
				86,
				120,
				144,
				171,
				205,
				239
			};
			byte[] bytes2 = Encoding.UTF8.GetBytes (encryptString);
			DESCryptoServiceProvider dESCryptoServiceProvider = new DESCryptoServiceProvider ();
			MemoryStream memoryStream = new MemoryStream ();
			CryptoStream cryptoStream = new CryptoStream (memoryStream, dESCryptoServiceProvider.CreateEncryptor (bytes, keys), CryptoStreamMode.Write);
			cryptoStream.Write (bytes2, 0, bytes2.Length);
			cryptoStream.FlushFinalBlock ();
			return Convert.ToBase64String (memoryStream.ToArray ());
		}

		public static string CutLeft (string originalVal, int cutLength)
		{
			//if (string.IsNullOrEmpty (originalVal))
			if (originalVal == null||originalVal==string.Empty)
			{
				return string.Empty;
			}
			if (cutLength < 1)
			{
				return originalVal;
			}
			byte[] bytes = Encoding.Default.GetBytes (originalVal);
			if (bytes.Length <= cutLength)
			{
				return originalVal;
			}
			int num = cutLength;
			int[] array = new int[cutLength];
			int num2 = 0;
			for (int i = 0; i < cutLength; i++)
			{
				if (bytes [i] > 127)
				{
					num2++;
					if (num2 == 3)
					{
						num2 = 1;
					}
				}
				else
				{
					num2 = 0;
				}
				array [i] = num2;
			}
			if (bytes [cutLength - 1] > 127 && array [cutLength - 1] == 1)
			{
				num = cutLength + 1;
			}
			byte[] array2 = new byte[num];
			Array.Copy (bytes, array2, num);
			return Encoding.Default.GetString (array2);
		}

		public static string DESDe (string Source)
		{
			string result;
			try
			{
				byte[] array = Convert.FromBase64String (Source);
				byte[] key = new byte[]
				{
					102,
					13,
					93,
					156,
					78,
					4,
					218,
					32
				};
				byte[] iV = new byte[]
				{
					55,
					103,
					246,
					79,
					36,
					99,
					167,
					3
				};
				DESCryptoServiceProvider dESCryptoServiceProvider = new DESCryptoServiceProvider ();
				dESCryptoServiceProvider.Key = key;
				dESCryptoServiceProvider.IV = iV;
				MemoryStream stream = new MemoryStream (array, 0, array.Length);
				ICryptoTransform transform = dESCryptoServiceProvider.CreateDecryptor ();
				CryptoStream stream2 = new CryptoStream (stream, transform, CryptoStreamMode.Read);
				StreamReader streamReader = new StreamReader (stream2, Encoding.Default);
				result = streamReader.ReadToEnd ();
			}
			catch
			{
				result = "error";
			}
			return result;
		}

		public static string DESEn (string strSource)
		{
			byte[] bytes = Encoding.Default.GetBytes (strSource);
			byte[] key = new byte[]
			{
				102,
				13,
				93,
				156,
				78,
				4,
				218,
				32
			};
			byte[] iV = new byte[]
			{
				55,
				103,
				246,
				79,
				36,
				99,
				167,
				3
			};
			//ICryptoTransform transform = new DESCryptoServiceProvider{Key = key,IV = iV}.CreateEncryptor ();
			DESCryptoServiceProvider dESCryptoServiceProvider = new DESCryptoServiceProvider ();
			dESCryptoServiceProvider.Key = key;
			dESCryptoServiceProvider.IV = iV;
			ICryptoTransform transform = dESCryptoServiceProvider.CreateEncryptor ();
			MemoryStream memoryStream = new MemoryStream ();
			CryptoStream cryptoStream = new CryptoStream (memoryStream, transform, CryptoStreamMode.Write);
			cryptoStream.Write (bytes, 0, bytes.Length);
			cryptoStream.FlushFinalBlock ();
			return Convert.ToBase64String (memoryStream.ToArray ());
		}

		private static byte[] GetMacFromBlob (byte[] bDataIn)
		{
			SHA1 sHA = SHA1.Create ();
			return sHA.ComputeHash (bDataIn);
		}

		private static byte[] GetMD5FromBlob (byte[] bDataIn)
		{
			MD5 mD = MD5.Create ();
			return mD.ComputeHash (bDataIn);
		}

		public static string HashPasswordForStoringInConfigFile (string password, string passwordFormat)
		{
			if (password == null)
			{
				throw new ArgumentNullException ("password");
			}
			if (passwordFormat == null)
			{
				throw new ArgumentNullException ("passwordFormat");
			}
			byte[] buf;
			//buf = GetMacFromBlob (Encoding.UTF8.GetBytes (password));//sha1
			buf = GetMD5FromBlob (Encoding.UTF8.GetBytes (password));//md5
			return ByteArrayToHexString (buf, 0);
		}

		public static string Md5 (string str, string strValue)
		{
			string str2 = string.Empty;
			//if (!string.IsNullOrWhiteSpace (strValue))
			if (strValue != null && strValue!=string.Empty)
			{
				str2 = Md5 (str) + strValue;
			}
			else
			{
				str2 = Md5 (str);
			}
			return Md5 (str2);
		}

		public static string Md5 (string str)
		{
			return HashPasswordForStoringInConfigFile (str, "md5").ToUpper ();
		}

		//
		// Static Methods
		//
		internal unsafe static string ByteArrayToHexString (byte[] buf, int iLen)
		{
			char[] array = s_acharval;
			if (array == null)
			{
				array = new char[16];
				int num = array.Length;
				while (--num >= 0)
				{
					if (num < 10)
					{
						array [num] = (char)(48 + num);
					}
					else
					{
						array [num] = (char)(65 + (num - 10));
					}
				}
				s_acharval = array;
			}
			if (buf == null)
			{
				return null;
			}
			if (iLen == 0)
			{
				iLen = buf.Length;
			}
			char[] array2 = new char[checked((uint)unchecked(iLen * 2))];
			fixed (char* ptr = &array2 [0], ptr2 = &array [0])
			{
				try
				{
					fixed (byte* ptr3 = &buf [0])
					{
						char* ptr4 = ptr;
						byte* ptr5 = ptr3;
						while (--iLen >= 0)
						{
							char* expr_7D = ptr4;
							ptr4 = expr_7D + 1;
							*expr_7D = ptr2 [(((*ptr5 & 240) >> 4)) ];
							char* expr_97 = ptr4;
							ptr4 = expr_97 + 1;
							*expr_97 = ptr2 [((*ptr5 & 15)) ];
							ptr5++;
						}
					}
				}
				finally
				{
					byte* ptr3 = null;
				}
			}
			return new string (array2);
		}

		private static char[] s_acharval;

		public Form1()
		{
			//
			// Windows 窗体设计器支持所必需的
			//
			InitializeComponent();

			//
			// TODO: 在 InitializeComponent 调用后添加任何构造函数代码
			//
		}

		/// <summary>
		/// 清理所有正在使用的资源。
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if (components != null) 
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		#region Windows 窗体设计器生成的代码
		/// <summary>
		/// 设计器支持所需的方法 - 不要使用代码编辑器修改
		/// 此方法的内容。
		/// </summary>
		private void InitializeComponent()
		{
			this.label1 = new System.Windows.Forms.Label();
			this.textBox1 = new System.Windows.Forms.TextBox();
			this.label2 = new System.Windows.Forms.Label();
			this.textBox2 = new System.Windows.Forms.TextBox();
			this.label3 = new System.Windows.Forms.Label();
			this.textBox3 = new System.Windows.Forms.TextBox();
			this.button1 = new System.Windows.Forms.Button();
			this.button2 = new System.Windows.Forms.Button();
			this.button3 = new System.Windows.Forms.Button();
			this.button4 = new System.Windows.Forms.Button();
			this.button5 = new System.Windows.Forms.Button();
			this.SuspendLayout();
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(40, 24);
			this.label1.Name = "label1";
			this.label1.TabIndex = 0;
			this.label1.Text = "源字符串：";
			// 
			// textBox1
			// 
			this.textBox1.Location = new System.Drawing.Point(168, 24);
			this.textBox1.Name = "textBox1";
			this.textBox1.Size = new System.Drawing.Size(376, 21);
			this.textBox1.TabIndex = 1;
			this.textBox1.Text = "";
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(40, 64);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(96, 16);
			this.label2.TabIndex = 2;
			this.label2.Text = "处理结果：";
			// 
			// textBox2
			// 
			this.textBox2.Location = new System.Drawing.Point(168, 56);
			this.textBox2.Name = "textBox2";
			this.textBox2.Size = new System.Drawing.Size(376, 21);
			this.textBox2.TabIndex = 3;
			this.textBox2.Text = "";
			// 
			// label3
			// 
			this.label3.Location = new System.Drawing.Point(40, 104);
			this.label3.Name = "label3";
			this.label3.TabIndex = 4;
			this.label3.Text = "DES密钥：";
			// 
			// textBox3
			// 
			this.textBox3.Location = new System.Drawing.Point(168, 96);
			this.textBox3.Name = "textBox3";
			this.textBox3.Size = new System.Drawing.Size(376, 21);
			this.textBox3.TabIndex = 5;
			this.textBox3.Text = "";
			// 
			// button1
			// 
			this.button1.Location = new System.Drawing.Point(48, 152);
			this.button1.Name = "button1";
			this.button1.TabIndex = 6;
			this.button1.Text = "HP加密";
			this.button1.Click += new System.EventHandler(this.button1_Click);
			// 
			// button2
			// 
			this.button2.Location = new System.Drawing.Point(152, 152);
			this.button2.Name = "button2";
			this.button2.TabIndex = 7;
			this.button2.Text = "HP解密";
			this.button2.Click += new System.EventHandler(this.button2_Click);
			// 
			// button3
			// 
			this.button3.Location = new System.Drawing.Point(280, 152);
			this.button3.Name = "button3";
			this.button3.TabIndex = 8;
			this.button3.Text = "加密";
			this.button3.Click += new System.EventHandler(this.button3_Click);
			// 
			// button4
			// 
			this.button4.Location = new System.Drawing.Point(384, 152);
			this.button4.Name = "button4";
			this.button4.TabIndex = 9;
			this.button4.Text = "解密";
			this.button4.Click += new System.EventHandler(this.button4_Click);
			// 
			// button5
			// 
			this.button5.Location = new System.Drawing.Point(512, 152);
			this.button5.Name = "button5";
			this.button5.TabIndex = 10;
			this.button5.Text = "管理员密码";
			this.button5.Click += new System.EventHandler(this.button5_Click);
			// 
			// Form1
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(6, 14);
			this.ClientSize = new System.Drawing.Size(632, 202);
			this.Controls.Add(this.button5);
			this.Controls.Add(this.button4);
			this.Controls.Add(this.button3);
			this.Controls.Add(this.button2);
			this.Controls.Add(this.button1);
			this.Controls.Add(this.textBox3);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.textBox2);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.textBox1);
			this.Controls.Add(this.label1);
			this.Name = "Form1";
			this.Text = "加密工具";
			this.ResumeLayout(false);

		}
		#endregion

		/// <summary>
		/// 应用程序的主入口点。
		/// </summary>
		[STAThread]
		static void Main() 
		{
			Application.Run(new Form1());
		}

		private void button1_Click(object sender, System.EventArgs e)
		{
			string strSrc = this.textBox1.Text;
			string strKey = this.textBox3.Text;//"Hei238q09j2qo4nHE32KWDMXIWS"
			string str1 = HPEncrypt(strSrc,strKey);
			this.textBox2.Text=str1;		
		}

		private void button2_Click(object sender, System.EventArgs e)
		{
			string strSrc = this.textBox1.Text;
			string strKey = this.textBox3.Text;//"Hei238q09j2qo4nHE32KWDMXIWS"
			string str1 = HPDecrypt(strSrc,strKey);
			this.textBox2.Text = str1;		
		}

		private void button3_Click(object sender, System.EventArgs e)
		{
			string strSrc = this.textBox1.Text;
			string strKey = this.textBox3.Text;//"nJxPx8^#b*2Wnn^wUzQOxP0Q%C5MI*uE"
			string str1 = Encrypt(strSrc,strKey);
			this.textBox2.Text=str1;		
		}

		private void button4_Click(object sender, System.EventArgs e)
		{
			string strSrc = this.textBox1.Text;
			string strKey = this.textBox3.Text;//"nJxPx8^#b*2Wnn^wUzQOxP0Q%C5MI*uE"
			string str1 = Decrypt(strSrc,strKey);
			this.textBox2.Text = str1;			
		}

		private void button5_Click(object sender, System.EventArgs e)
		{
	        this.textBox2.Text = Md5 (this.textBox1.Text, "@!#DD");	
		}
	}
}
