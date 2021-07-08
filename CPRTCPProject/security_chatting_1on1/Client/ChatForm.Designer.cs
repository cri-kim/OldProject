namespace Client
{
    partial class ChatForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.contentText = new System.Windows.Forms.RichTextBox();
            this.inputButton = new System.Windows.Forms.Button();
            this.textBox = new System.Windows.Forms.TextBox();
            this.SuspendLayout();
            // 
            // contentText
            // 
            this.contentText.Enabled = false;
            this.contentText.Location = new System.Drawing.Point(53, 34);
            this.contentText.Name = "contentText";
            this.contentText.Size = new System.Drawing.Size(681, 332);
            this.contentText.TabIndex = 0;
            this.contentText.Text = "";
            // 
            // inputButton
            // 
            this.inputButton.Location = new System.Drawing.Point(659, 394);
            this.inputButton.Name = "inputButton";
            this.inputButton.Size = new System.Drawing.Size(75, 23);
            this.inputButton.TabIndex = 1;
            this.inputButton.Text = "접속하기";
            this.inputButton.UseVisualStyleBackColor = true;
            this.inputButton.Click += new System.EventHandler(this.inputButton_Click);
            // 
            // textBox
            // 
            this.textBox.Location = new System.Drawing.Point(53, 392);
            this.textBox.Name = "textBox";
            this.textBox.Size = new System.Drawing.Size(562, 25);
            this.textBox.TabIndex = 2;
            // 
            // ChatForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.textBox);
            this.Controls.Add(this.inputButton);
            this.Controls.Add(this.contentText);
            this.Name = "ChatForm";
            this.Text = "ChatForm";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.RichTextBox contentText;
        private System.Windows.Forms.Button inputButton;
        private System.Windows.Forms.TextBox textBox;
    }
}