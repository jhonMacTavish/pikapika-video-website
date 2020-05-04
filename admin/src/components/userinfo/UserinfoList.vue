<template>
  <div>
    <h1>用户列表</h1>
    <div>
      <el-button type="text" @click="$router.push('/userinfo/create')">
        <i class="el-icon-plus"></i>添加用户
      </el-button>
    </div>
    <el-table :data="pageList" stripe>
      <el-table-column type="index" width="50"></el-table-column>
      <el-table-column prop="u_name" label="名称"></el-table-column>
      <el-table-column prop="u_email" label="邮箱"></el-table-column>
      <el-table-column prop="u_sex" label="性别">
        <template slot-scope="scope">{{scope.row.u_sex==1?"女":"男"}}</template>
      </el-table-column>
      <el-table-column prop="u_avatar" label="头像"></el-table-column>
      <el-table-column fixed="right" label="操作" width="180">
        <template slot-scope="scope">
          <el-button type="text" size="small" @click="detail(scope.row.u_id)" class="detail">查看</el-button>
          <!-- <el-button
            type="text"
            size="small"
            @click="$router.push(`/userinfo/eidt/${scope.row.u_id}`)"
            class="deit"
          >编辑</el-button>-->
          <el-button type="text" size="small" @click="remove(scope.row)" class="delete">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <div class="window-pagination">
      <el-pagination
        @current-change="handleCurrentChange"
        :current-page.sync="currentPage"
        :page-size="10"
        layout="total, prev, pager, next"
        :total="totalItems"
        background
      ></el-pagination>
    </div>

    <el-dialog title="用户信息" :visible.sync="dialogFormVisible">
      <el-form :model="model" label-width="100px" style="margin-right: 0;">
        <el-form-item label="名称" class="form-item">
          <p>{{model.u_name}}</p>
        </el-form-item>

        <el-form-item label="邮箱" class="form-item">
          <p>{{model.u_email}}</p>
        </el-form-item>
        <el-form-item label="性别" class="form-item">
          <p>{{model.u_sex==1?"女":"男"}}</p>
        </el-form-item>
        <el-form-item label="头像" class="form-item">
          <p>{{model.u_avatar}}</p>
        </el-form-item>
      </el-form>
      <!-- <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false" class="close">关 闭</el-button>
      </div> -->
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "BangumiList",
  data() {
    return {
      dialogFormVisible: false,
      pageList: [],
      currentPage: 1,
      model: {}
    };
  },
  async created() {
    await this.fetch();
  },
  computed: {
    userinfoList() {
      return this.$store.getters.userinfoList;
    },

    totalItems() {
      return this.$store.getters.userinfoList.length;
    }
  },
  beforeUpdate() {},
  watch: {},
  methods: {
    async fetch() {
      const res = await this.$http.get("/userinfos");
      this.$store.dispatch("updateUserinfoList", res.data.list);

      if (Math.ceil(this.totalItems / 10) < this.currentPage) {
        --this.currentPage;
      }
      this.handleCurrentChange(this.currentPage);
    },

    async remove(row) {
      this.$confirm(`是否确定要删除用户 "${row.u_name}"`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(async () => {
          const res = await this.$http.delete(`/userinfos/${row.u_id}`);
          console.log("delete", res);
          if (res.data.status == 200) {
            this.$message({
              type: "success",
              message: res.data.msg
            });
            this.fetch();
          } else {
            this.$message({
              type: "success",
              message: res.data.msg
            });
          }
        })
        .catch(() => {
          return;
        });
    },

    handleCurrentChange(val) {
      if (val < 1) {
        val = 1;
      }
      let pageList = [];
      for (
        let i = 10 * (val - 1);
        i < (10 * val < this.totalItems ? 10 * val : this.totalItems);
        i++
      ) {
        pageList.push(this.userinfoList[i]);
      }
      this.pageList = pageList;
      // document.querySelector("counter1").scrollIntoView(true); //这里的counter1是将要返回地方的id
    },

    async detail(u_id) {
      const res = await this.$http.post(`/userinfos/${u_id}`);
      this.model = res.data[0];
      this.dialogFormVisible = true;
      console.log("this.model", this.model);
    }
  },
  components: {}
};
</script>

<style lang='less' scoped>
.detail {
  color: #409eff;
}

.deit {
  color: #67c23a;
}

.delete {
  color: #f56c6c;
}

.form-item {
  font-weight: bold;
  margin: 5px 0;
}

.form-item:nth-child(even) {
  background: #fafafa;
}

.form-item:hover {
  background: rgba(100, 150, 200, 0.1);
}

p {
  font-weight: normal;
  margin: 0;
  padding: 0;
  margin-left: 50px;
}
.window-pagination {
  display: inline-block;
  margin-top: 30px;
  margin-left: 50%;
  transform: translateX(-50%);
}
</style>
