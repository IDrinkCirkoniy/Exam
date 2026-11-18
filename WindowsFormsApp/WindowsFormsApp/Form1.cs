using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void productsBindingNavigatorSaveItem_Click(object sender, EventArgs e)
        {
            this.Validate();
            this.productsBindingSource.EndEdit();
            this.tableAdapterManager.UpdateAll(this.shopDataSet);

        }


        private void ценапоВозрастаниюToolStripMenuItem_Click(object sender, EventArgs e)
        {
            productsBindingSource.Sort = "Price";
        }

        private void ценапоУбываниюToolStripMenuItem_Click(object sender, EventArgs e)
        {
            productsBindingSource.Sort = "Price DESC";
        }

        private void productsDataGridView_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var value = toolStripTextBox1.Text;
            productsBindingSource.Filter = $"name LIKE '%{value}'";
        }
    }
}
