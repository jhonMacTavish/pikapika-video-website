<template>
  <div>
    <h1>举报处理列表</h1>
    <el-table :data="reportList" stripe>
      <el-table-column type="index" width="50"></el-table-column>
      <el-table-column prop="commentator.username" label="评论人" width="160">
        <template slot-scope="scope">
          <el-button type="text" size="small" @click="userDetail(scope.row.commentator)">{{scope.row.commentator.username}}</el-button>
        </template>
      </el-table-column>
      <el-table-column prop="content" label="评论内容"></el-table-column>
      <el-table-column prop="whistleblower.username" label="举报人" width="160">
        <template slot-scope="scope">
          <el-button type="text" size="small" @click="userDetail(scope.row.whistleblower)">{{scope.row.whistleblower.username}}</el-button>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="180">
        <template slot-scope="scope">
          <el-button type="text" size="small" class="edit" @click="relieveReport(scope.row)">解除举报</el-button>
          <el-button type="text" size="small" @click="remove(scope.row)" class="delete">删除评论</el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-dialog title="用户信息" :visible.sync="dialogFormVisibleU">
      <el-form :model="modelU" label-width="100px">
        <el-form-item label="用户名" class="form-item">
          <p>{{modelU.username}}</p>
        </el-form-item>
        <el-form-item label="用户头像" class="form-item">
          <p>
            <img :src="modelU.avatar?modelU.avatar:userAvatar" alt />
          </p>
        </el-form-item>
        <el-form-item label="性别" class="form-item">
          <p>{{modelU.is_man==1?"女":"男"}}</p>
        </el-form-item>
        <el-form-item label="邮箱" class="form-item">
          <p>{{modelU.email}}</p>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="danger" @click="banUser(user)" class="close">封禁用户</el-button>
        <el-button @click="dialogFormVisibleU = false;user=null" class="close">关 闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "BangumiList",
  data() {
    return {
      reportList: [],
      modelU: {},
      dialogFormVisibleU: false,
      userAvatar: "../../../static/userAvatar.jpg",
      user:null
    };
  },
  async created() {},
  computed: {},
  watch: {},
  methods: {
    async fetch() {
      const res = await this.$http.get("/commentReporting");
      console.log("res*********", res);
      this.reportList = res.data.list;
    },

    async relieveReport(row) {
      this.$confirm(
        `是否确定要解除"${row.commentator.username}"的评论的举报状态吗`,
        "提示",
        {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }
      )
        .then(async () => {
          const res = await this.$http.delete(`/comments/reports/${row.reporting_id}`);
          if (res.data.status == 200) {
            this.$message({
              type: "success",
              message: res.data.msg
            });
            this.fetch();
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

    async remove(row) {
      this.$confirm(
        `是否确定要删除"${row.commentator.username}"的评论吗`,
        "提示",
        {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }
      )
        .then(async () => {
          const res = await this.$http.delete(`/comments/${row.comment_id}`);
          if (res.data.status == 200) {
            this.$message({
              type: "success",
              message: res.data.msg
            });
            this.fetch();
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

    async userDetail(user) {
      const res = await this.$http.post(`/userinfos/${user.user_id}`);
      this.modelU = res.data[0];
      this.dialogFormVisibleU = true;
      this.user = user;
      //console.log("this.modelU", this.modelU);
    },

    async banUser(row) {
      this.$confirm(`是否确定要封禁用户"${row.username}"`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(async () => {
          let params = {is_banned:1}
          const res = await this.$http.put(`/userinfos/${row.user_id}`,{params});
          //console.log("delete", res);
          if (res.data.status == 200) {
            this.dialogFormVisibleU=false;
            this.$message({
              type: "success",
              message: res.data.msg
            });
            this.fetch();
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
  },
  components: {},
  beforeRouteEnter(to, from, next) {
    next(async vm => {
      await vm.fetch();
    });
  }
};
</script>

<style lang='less' scoped>
.edit {
  color: #67c23a;
}

.delete {
  color: #f56c6c;
}

.form-item {
  font-weight: bold;
  margin: 5px 0;

img {
  height: 40px;
  width: 40px;
  border-radius: 50%;
  border: 1px solid rgba(0, 0, 0, 0.1);
  margin-bottom: -12px;
}
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
  margin-left: 30px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  width: 90%;
}
</style>
