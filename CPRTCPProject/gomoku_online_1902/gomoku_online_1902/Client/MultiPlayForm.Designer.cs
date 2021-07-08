namespace Client
{
    partial class MultiPlayForm
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
            this.boardPicture = new System.Windows.Forms.PictureBox();
            this.roomTextBox = new System.Windows.Forms.TextBox();
            this.enterButton = new System.Windows.Forms.Button();
            this.playButton = new System.Windows.Forms.Button();
            this.status = new System.Windows.Forms.Label();
            this.clientTextBox = new System.Windows.Forms.TextBox();
            this.client = new System.Windows.Forms.Label();
            this.room = new System.Windows.Forms.Label();
            this.connectButton = new System.Windows.Forms.Button();
            this.showRankButton = new System.Windows.Forms.Button();
            this.myRankText = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.boardPicture)).BeginInit();
            this.SuspendLayout();
            // 
            // boardPicture
            // 
            this.boardPicture.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(216)))));
            this.boardPicture.Location = new System.Drawing.Point(14, 15);
            this.boardPicture.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.boardPicture.Name = "boardPicture";
            this.boardPicture.Size = new System.Drawing.Size(571, 625);
            this.boardPicture.TabIndex = 0;
            this.boardPicture.TabStop = false;
            this.boardPicture.Paint += new System.Windows.Forms.PaintEventHandler(this.boardPicture_Paint);
            this.boardPicture.MouseDown += new System.Windows.Forms.MouseEventHandler(this.boardPicture_MouseDown);
            // 
            // roomTextBox
            // 
            this.roomTextBox.Location = new System.Drawing.Point(739, 97);
            this.roomTextBox.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.roomTextBox.Name = "roomTextBox";
            this.roomTextBox.Size = new System.Drawing.Size(93, 25);
            this.roomTextBox.TabIndex = 1;
            // 
            // enterButton
            // 
            this.enterButton.Location = new System.Drawing.Point(861, 85);
            this.enterButton.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.enterButton.Name = "enterButton";
            this.enterButton.Size = new System.Drawing.Size(114, 50);
            this.enterButton.TabIndex = 2;
            this.enterButton.Text = "입장하기";
            this.enterButton.UseVisualStyleBackColor = true;
            this.enterButton.Click += new System.EventHandler(this.enterButton_Click);
            // 
            // playButton
            // 
            this.playButton.Location = new System.Drawing.Point(739, 165);
            this.playButton.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.playButton.Name = "playButton";
            this.playButton.Size = new System.Drawing.Size(114, 50);
            this.playButton.TabIndex = 3;
            this.playButton.Text = "게임시작";
            this.playButton.UseVisualStyleBackColor = true;
            this.playButton.Click += new System.EventHandler(this.playButton_Click);
            // 
            // status
            // 
            this.status.Location = new System.Drawing.Point(644, 232);
            this.status.Name = "status";
            this.status.Size = new System.Drawing.Size(311, 19);
            this.status.TabIndex = 4;
            this.status.Text = "아이디와 방을 입력하여 접속해주세요.";
            this.status.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // clientTextBox
            // 
            this.clientTextBox.Location = new System.Drawing.Point(739, 36);
            this.clientTextBox.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.clientTextBox.Name = "clientTextBox";
            this.clientTextBox.Size = new System.Drawing.Size(93, 25);
            this.clientTextBox.TabIndex = 5;
            // 
            // client
            // 
            this.client.Location = new System.Drawing.Point(591, 37);
            this.client.Name = "client";
            this.client.Size = new System.Drawing.Size(133, 24);
            this.client.TabIndex = 6;
            this.client.Text = "아이디";
            this.client.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // room
            // 
            this.room.Location = new System.Drawing.Point(591, 95);
            this.room.Name = "room";
            this.room.Size = new System.Drawing.Size(133, 24);
            this.room.TabIndex = 7;
            this.room.Text = "방번호";
            this.room.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // connectButton
            // 
            this.connectButton.Location = new System.Drawing.Point(861, 26);
            this.connectButton.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.connectButton.Name = "connectButton";
            this.connectButton.Size = new System.Drawing.Size(114, 50);
            this.connectButton.TabIndex = 8;
            this.connectButton.Text = "접속하기";
            this.connectButton.UseVisualStyleBackColor = true;
            this.connectButton.Click += new System.EventHandler(this.connectButton_Click);
            // 
            // showRankButton
            // 
            this.showRankButton.Enabled = false;
            this.showRankButton.Location = new System.Drawing.Point(739, 279);
            this.showRankButton.Name = "showRankButton";
            this.showRankButton.Size = new System.Drawing.Size(114, 50);
            this.showRankButton.TabIndex = 9;
            this.showRankButton.Text = "내 랭킹보기";
            this.showRankButton.UseVisualStyleBackColor = true;
            this.showRankButton.Click += new System.EventHandler(this.showRankButton_Click);
            // 
            // myRankText
            // 
            this.myRankText.AutoSize = true;
            this.myRankText.Enabled = false;
            this.myRankText.Location = new System.Drawing.Point(763, 356);
            this.myRankText.Name = "myRankText";
            this.myRankText.Size = new System.Drawing.Size(55, 15);
            this.myRankText.TabIndex = 10;
            this.myRankText.Text = "NoData";
            this.myRankText.Visible = false;
            // 
            // MultiPlayForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(987, 676);
            this.Controls.Add(this.myRankText);
            this.Controls.Add(this.showRankButton);
            this.Controls.Add(this.connectButton);
            this.Controls.Add(this.room);
            this.Controls.Add(this.client);
            this.Controls.Add(this.clientTextBox);
            this.Controls.Add(this.status);
            this.Controls.Add(this.playButton);
            this.Controls.Add(this.enterButton);
            this.Controls.Add(this.roomTextBox);
            this.Controls.Add(this.boardPicture);
            this.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.Name = "MultiPlayForm";
            this.Text = "MultiPlayForm";
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.MultiPlayForm_FormClosed);
            ((System.ComponentModel.ISupportInitialize)(this.boardPicture)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.PictureBox boardPicture;
        private System.Windows.Forms.TextBox roomTextBox;
        private System.Windows.Forms.Button enterButton;
        private System.Windows.Forms.Button playButton;
        private System.Windows.Forms.Label status;
        private System.Windows.Forms.TextBox clientTextBox;
        private System.Windows.Forms.Label client;
        private System.Windows.Forms.Label room;
        private System.Windows.Forms.Button connectButton;
        private System.Windows.Forms.Button showRankButton;
        private System.Windows.Forms.Label myRankText;
    }
}