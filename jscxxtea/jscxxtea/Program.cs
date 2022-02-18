using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Berrysoft.XXTea;
using System.IO;
using System.IO.Compression;

namespace jscxxtea
{
    class Program
    {
        static void Main(string[] args)
        {
            if (args.Length < 3) {
                Console.Write("Usage:  jscxxtea [-e][-d] key path\n");
                return;
            }
            string key = args[1];
            string path = args[2];
            byte[] bytes2 = Encoding.ASCII.GetBytes(key);
            if (args[0] == "-e")
            {//加密,eg:jscxxtea -e 105ba178-b9b1-44 index.e36aa.raw
                try
                {
                    string path1= path.Substring(0, path.Length - 4) + ".jsc";
                    FileStream fileStream0 = new FileStream(path, FileMode.Open);
                    MemoryStream memoryStream = new MemoryStream();
                    GZipStream gZipStream = new GZipStream(memoryStream, CompressionMode.Compress);
                    XXTeaCryptor xXTeaCryptor0 = new XXTeaCryptor();
                    fileStream0.CopyTo(gZipStream);
                    gZipStream.Close();
                    memoryStream.Close();
                    byte[] array0 = memoryStream.ToArray();
                    byte[] array02 = xXTeaCryptor0.Encrypt(array0, bytes2, 32);
                    bool flag2 = array02.Length < 1;
                    if (flag2)
                    {
                        Console.WriteLine("加密{0}失败，请检测密钥", path);
                        return;
                    }
                    FileStream fileStream02 = new FileStream(path1, FileMode.Create);
                    fileStream02.Write(array02, 0, array02.Length);
                    fileStream02.Close();
                    Console.WriteLine("加密成功:{0}->{1}", path, path1);
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                    return;
                }
                return;
            }
            if (args[0] == "-d")
            {//解密,新的cocos方法解压,eg:jscxxtea -d 105ba178-b9b1-44 index.e36aa.jsc
                FileStream fileStream = new FileStream(path, FileMode.Open);
                byte[] bytes = new byte[fileStream.Length];
                fileStream.Read(bytes, 0, (int)fileStream.Length);
                fileStream.Close();
                XXTeaCryptor xXTeaCryptor = new XXTeaCryptor();
                byte[] bytes3 = xXTeaCryptor.Decrypt(bytes, bytes2, 32);
                bool flag = bytes3.Length < 1;
                if (flag) {
                    Console.WriteLine("解密{0}失败，请检测密钥", path);
                }else {
                    string path0 = path.Substring(0, path.Length - 4) + ".raw.zip";
                    string path1 = path.Substring(0, path.Length - 4) + ".raw";
                    FileStream fileStream2 = new FileStream(path0, FileMode.Create);
                    fileStream2.Write(bytes3, 0, bytes3.Length);
                    fileStream2.Close();
                    try {
                        using (MemoryStream memoryStream = new MemoryStream(bytes3))
                        {
                            using (GZipStream gZipStream = new GZipStream(memoryStream, CompressionMode.Decompress))
                            {
                                using (StreamReader streamReader = new StreamReader(gZipStream, Encoding.UTF8))
                                {
                                    string Text1 = streamReader.ReadToEnd();
                                    FileStream fileStream3 = new FileStream(path1, FileMode.Create);
                                    StreamWriter streamWriter = new StreamWriter(fileStream3);
                                    streamWriter.Write(Text1);
                                    streamWriter.Close();
                                    fileStream3.Close();
                                    Console.WriteLine("解密成功:{0}->{1}", path, path1);
                                    if (File.Exists(path0))
                                    {
                                        File.Delete(path0);
                                    }
                                }
                            }
                        }
                    }
                    catch (Exception ex){
                        Console.WriteLine(ex.Message);
                    }
                }
                return;
            }
            Console.WriteLine("未知命令");
            return;
        }
    }
}
