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

        private void Form1_Load(object sender, EventArgs e)
        {
            // TODO: данная строка кода позволяет загрузить данные в таблицу "shopDataSet.Category". При необходимости она может быть перемещена или удалена.
            this.categoryTableAdapter.Fill(this.shopDataSet.Category);
            
            
            // TODO: данная строка кода позволяет загрузить данные в таблицу "shopDataSet.Products". При необходимости она может быть перемещена или удалена.
            this.productsTableAdapter.Fill(this.shopDataSet.Products);

            var all = shopDataSet.Category.NewCategoryRow();
            all.Name = "Все категории";
            shopDataSet.Category.Rows.InsertAt(all, 0);
            categoryComboBox.SelectedIndex = 0;
        }

        private void ценапоВозрастаниюToolStripMenuItem_Click(object sender, EventArgs e)
        {
            productsBindingSource.Sort = "Price";
        }

        private void ценапоУбываниюToolStripMenuItem_Click(object sender, EventArgs e)
        {
            productsBindingSource.Sort = "Price DESC";
        }

        private void categoryComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (categoryComboBox.SelectedIndex < 1)
            {
                productsBindingSource.Filter = "";
                return;
            }
                
            var value = categoryComboBox.SelectedValue;
            if (value != null)
            productsBindingSource.Filter = $"category = '{value}'";
        }

        private void toolStripComboBox1_TextChanged(object sender, EventArgs e)
        {
            var value = toolStripTextBox1.Text;
            productsBindingSource.Filter = $"name LIKE '%{value}%'";
        }

        private void productsDataGridView_DataError(object sender, DataGridViewDataErrorEventArgs e)
        {

        }

        private void toolStripTextBox1_TextChanged(object sender, EventArgs e)
        {
            var value = toolStripTextBox1.Text;
            productsBindingSource.Filter = $"name LIKE '%{value}%'";
        }
    }
}
