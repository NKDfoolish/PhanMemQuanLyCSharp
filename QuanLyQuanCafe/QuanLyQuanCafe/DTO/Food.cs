﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCafe.DTO
{
    public class Food
    {
        private int iD;
        private string name;
        private string categoryID;
        private float price;

        public Food(int id, string name, string categoryId, float price)
        {
            this.ID = id;
            this.Name = name;
            this.CategoryID = categoryId;
            this.Price = price;
        }

        public Food(DataRow row)
        {
            this.ID = (int)row["id"];
            this.Name = row["name"].ToString();
            this.CategoryID = row["idCategory"].ToString();
            this.Price = (float)Convert.ToDouble(row["price"].ToString());
        }

        public int ID { get => iD; set => iD = value; }
        public string Name { get => name; set => name = value; }
        public string CategoryID { get => categoryID; set => categoryID = value; }
        public float Price { get => price; set => price = value; }
    }
}
