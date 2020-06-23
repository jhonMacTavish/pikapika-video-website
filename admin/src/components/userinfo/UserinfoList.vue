<template>
  <div>
    <h1>用户列表</h1>
    <div class="button-wrap">
      <el-button type="text" @click="$router.push('/userinfo/create')">
        <i class="el-icon-plus"></i>添加用户
      </el-button>

      <el-switch
        class="switch"
        v-model="isbanUser"
        active-color="#ff4949"
        inactive-color="#13ce66"
        active-text="封禁用户"
        inactive-text="正常用户"
      ></el-switch>
    </div>
    <el-table :data="pageList" stripe>
      <el-table-column type="index" width="50"></el-table-column>
      <el-table-column prop="username" label="名称"></el-table-column>
      <el-table-column prop="email" label="邮箱"></el-table-column>
      <el-table-column prop="is_man" label="性别">
        <template slot-scope="scope">{{scope.row.is_man==1?"男":"女"}}</template>
      </el-table-column>
      <el-table-column prop="avatar" label="头像">
        <template slot-scope="scope">
          <img :src="scope.row.avatar?scope.row.avatar:userAvatar" alt />
        </template>
      </el-table-column>
      <el-table-column fixed="right" label="操作" width="180">
        <template slot-scope="scope">
          <el-button v-if="!isbanUser" type="text" size="small" @click="detail(scope.row.user_id)" class="detail">查看</el-button>
          <el-button v-if="!isbanUser" type="text" size="small" @click="banUser(scope.row)" class="delete">封禁</el-button>
          <el-button v-else type="text" size="small" @click="relieveBan(scope.row)">解封</el-button>
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
          <p>{{model.username}}</p>
        </el-form-item>

        <el-form-item label="邮箱" class="form-item">
          <p>{{model.email}}</p>
        </el-form-item>
        <el-form-item label="性别" class="form-item">
          <p>{{model.is_man==1?"女":"男"}}</p>
        </el-form-item>
        <el-form-item label="头像" class="form-item">
          <p>
            <img :src="model.avatar?model.avatar:userAvatar" alt />
          </p>
          <!-- <p>{{model.avatar}}</p> -->
        </el-form-item>
        <el-form-item label="创建时间" class="form-item">
          <p>{{model.create_time}}</p>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false" class="close">关 闭</el-button>
      </div>
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
      userAvatar: "../../../static/userAvatar.jpg",
      userinfoList: [],
      banuserList: [],
      isbanUser: false
    };
  },
  async created() {
    // await this.fetch();
  },
  computed: {
    totalItems() {
      if(!this.isbanUser){
        return this.userinfoList.length;
      }else{
        return this.banuserList.length;
      }
    }
  },
  watch: {
    isbanUser(newV,oldV){
      this.handleCurrentChange(1);
    }
  },
  methods: {
    async fetch() {
      const res = await this.$http.get("/userinfos");
      let arr = res.data.list;
      this.banuserList = [];
      this.userinfoList = [];
      for (let i = 0; i < arr.length; i++) {
        if (arr[i].is_banned) {
          this.banuserList.push(arr[i]);
        } else {
          this.userinfoList.push(arr[i]);
        }
      }

      //console.log("banuserList", this.banuserList);
      //console.log("userinfoList", this.userinfoList);

      if (Math.ceil(this.totalItems / 10) < this.currentPage) {
        --this.currentPage;
      }
      this.handleCurrentChange(this.currentPage);
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

    async relieveBan(row) {
      this.$confirm(`是否确定要解封用户"${row.username}"`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(async () => {
           let params = {is_banned:0}
          const res = await this.$http.put(`/userinfos/${row.user_id}`,{params});
          //console.log("delete", res);
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
        if (!this.isbanUser) {
          pageList.push(this.userinfoList[i]);
        } else {
          pageList.push(this.banuserList[i]);
        }
      }
      this.pageList = pageList;
      // document.querySelector("counter1").scrollIntoView(true); //这里的counter1是将要返回地方的id
    },

    async detail(user_id) {
      const res = await this.$http.post(`/userinfos/${user_id}`);
      res.data[0]?this.model = res.data[0]:'';
      this.dialogFormVisible = true;
      //console.log("this.model", this.model);
    }
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

img {
  height: 40px;
  width: 40px;
  border-radius: 50%;
  border: 1px solid rgba(0, 0, 0, 0.1);
}

.button-wrap {
  position: relative;
  .switch {
    position: absolute;
    right: 0;
  }
}
</style>
