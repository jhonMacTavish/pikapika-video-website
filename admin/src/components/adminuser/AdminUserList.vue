<template>
  <div>
    <h1>管理员列表</h1>
    <div>
      <el-button type="text" @click="$router.push('/adminuser/create')">
        <i class="el-icon-plus"></i>添加管理员
      </el-button>
    </div>
    <el-table :data="pageList" stripe>
      <el-table-column type="index" width="50"></el-table-column>
      <el-table-column prop="name" label="姓名" width="200"></el-table-column>
      <el-table-column prop="email" label="邮箱"></el-table-column>
      <el-table-column prop="create_time" label="创建时间">
        <template slot-scope="scope">
          <span>{{scope.row.create_time.replace(/T|.000Z/g," ")}}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="120">
        <template slot-scope="scope">
          <el-button
            type="text"
            size="small"
            @click="$router.push(`/adminuser/eidt/${scope.row.admin_id}`)"
            class="edit"
          >编辑</el-button>
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

    <el-dialog title="管理员信息" :visible.sync="dialogFormVisible">
      <el-form :model="model" label-width="100px" style="margin-right: 0;">
        <el-form-item label="姓名" class="form-item">
          <p>{{model.name}}</p>
        </el-form-item>

        <el-form-item label="邮箱" class="form-item">
          <p>{{model.email}}</p>
        </el-form-item>
      </el-form>
      <!-- <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false" class="close">关 闭</el-button>
      </div>-->
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
      model: {},
      adminUserList: [],
      totalItems: 0
    };
  },
  async created() {
    // await this.fetch();
  },
  computed: {},
  watch: {},
  methods: {
    async fetch() {
      const res = await this.$http.get("/adminusers");
      this.adminUserList = res.data.list;
      this.totalItems = res.data.list.length;

      if (Math.ceil(this.totalItems / 10) < this.currentPage) {
        --this.currentPage;
      }
      this.handleCurrentChange(this.currentPage);
    },

    async remove(row) {
      this.$confirm(`是否确定要删除管理员 "${row.name}"`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(async () => {
          //console.log("row.admin_id", row.admin_id);
          const res = await this.$http.delete(`/adminusers/${row.admin_id}`);
          //console.log("delete", res);
          if (res.data.status == 200) {
            this.$message({
              type: "success",
              message: res.data.msg
            });
            await this.fetch();
          } else {
            this.$message({
              type: "error",
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
        pageList.push(this.adminUserList[i]);
      }
      this.pageList = pageList;
      // document.querySelector("counter1").scrollIntoView(true); //这里的counter1是将要返回地方的id
    }
  },
  components: {},
  beforeRouteEnter(to, from, next) {
    next(async vm => {
      if(to.path.indexOf("adminuser")>=0 && !vm.$store.getters.adminUser.superAdmin){
        vm.$router.push('/');
      }
      await vm.fetch();
    });
  }
};
</script>

<style lang='less' scoped>
.edit {
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

img {
  height: 40px;
  width: 40px;
  border-radius: 50%;
  border: 1px solid rgba(0, 0, 0, 0.1);
}
</style>
