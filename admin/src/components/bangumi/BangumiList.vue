<template>
  <div class="container">
    <h1>番剧列表</h1>
    <div>
      <el-button type="text" @click="$router.push('/bangumi/create')">
        <i class="el-icon-plus"></i>添加番剧
      </el-button>
    </div>
    <el-table :data="pageListB" stripe>
      <el-table-column type="index" width="50"></el-table-column>
      <el-table-column prop="b_name" label="名称"></el-table-column>
      <el-table-column prop="b_episodes" label="集数"></el-table-column>
      <el-table-column prop="b_style" label="风格"></el-table-column>
      <el-table-column prop="b_playtime" label="开播时间"></el-table-column>
      <el-table-column fixed="right" label="操作" width="180">
        <template slot-scope="scope">
          <el-button type="text" size="small" @click="detail(scope.row.v_id)" class="detail">查看</el-button>
          <el-button
            type="text"
            size="small"
            @click="$router.push(`/bangumi/eidt/${scope.row.v_id}`)"
            class="deit"
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
        :total="bangumiTotal"
        background
      ></el-pagination>
    </div>

    <el-dialog title="番剧信息" :visible.sync="dialogFormVisible">
      <el-tabs type="border-card" v-model="activeName" @tab-click="handleClick">
        <el-tab-pane label="基本信息" name="first" class="panel">
          <el-form :model="model" label-width="100px">
            <el-form-item label="名称" class="form-item">
              <p>{{model.b_name}}</p>
            </el-form-item>
            <el-form-item label="类型" class="form-item">
              <p>{{model.t_id==1?"番剧":model.t_id==2?"国漫":model.t_id==3?"电影":"影视"}}</p>
            </el-form-item>

            <el-form-item label="总集数" class="form-item">
              <p>{{model.b_episodes}}</p>
            </el-form-item>
            <el-form-item label="状态" class="form-item">
              <p>{{model.b_status==1?"更新中":"已完结"}}</p>
            </el-form-item>
            <el-form-item label="风格" class="form-item">
              <p>{{model.b_style}}</p>
            </el-form-item>
            <el-form-item label="首字母" class="form-item">
              <p>{{model.b_initials}}</p>
            </el-form-item>
            <el-form-item label="开播时间" class="form-item">
              <p>{{model.b_playtime}}</p>
            </el-form-item>
            <el-form-item label="声优" class="form-item">
              <p>{{model.b_actors}}</p>
            </el-form-item>
            <el-form-item label="图片地址" class="form-item">
              <p>{{model.b_imgSrc}}</p>
            </el-form-item>
            <el-form-item label="简介" class="form-item">
              <p class="lastP">{{model.b_summary | summarySplice}}</p>
            </el-form-item>
          </el-form>
        </el-tab-pane>
        <el-tab-pane label="视频资源" name="second" class="panel">
          <el-table :data="pageListV" stripe>
            <!-- <el-table-column type="index" width="50"></el-table-column> -->
            <el-table-column prop="r_episode" label="章节" width="50"></el-table-column>
            <el-table-column prop="r_address" label="视频链接">
              <template slot-scope="scope">{{scope.row.r_address | videoLinkSplice}}</template>
            </el-table-column>
          </el-table>
          <div class="video-pagination">
            <el-pagination
              @current-change="videoCurrentChange"
              :current-page.sync="videoCurrentPage"
              :page-size="10"
              layout="total, prev, pager, next"
              :total="videoTotal"
              background
            ></el-pagination>
          </div>
        </el-tab-pane>
      </el-tabs>
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
      pageListB: [],
      pageListV: [],
      currentPage: 1,
      videoCurrentPage: 1,
      model: {},
      activeName: "first",
    };
  },
  async created() {
    await this.fetch();
  },
  computed: {
    bangumiList() {
      return this.$store.getters.bangumiList;
    },

    bangumiTotal() {
      return this.$store.getters.bangumiList.length;
    },

    videoList() {
      return this.$store.getters.videoList;
    },

    videoTotal() {
      return this.$store.getters.videoList.length;
    },
  },
  watch: {},
  methods: {
    async fetch() {
      const res = await this.$http.get("/bangumis");
      this.$store.dispatch("updateBangumiList", res.data.list);

      if (Math.ceil(this.bangumiTotal / 10) < this.currentPage) {
        --this.currentPage;
      }
      this.handleCurrentChange(this.currentPage);
    },

    async remove(row) {
      this.$confirm(`是否确定要删除番剧 "${row.b_name}"`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(async () => {
          const res = await this.$http.delete(`/bangumis/${row.v_id}`);
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
        i < (10 * val < this.bangumiTotal ? 10 * val : this.bangumiTotal);
        i++
      ) {
        pageList.push(this.bangumiList[i]);
      }
      this.pageListB = pageList;
      // document.querySelector("counter1").scrollIntoView(true); //这里的counter1是将要返回地方的id
    },

    videoCurrentChange(val) {
      if (Math.ceil(this.videoTotal / 10) < this.videoCurrentPage) {
        --this.videoCurrentPage;
      }

      if (val < 1) {
        val = 1;
      }
      let pageList = [];
      for (
        let i = 10 * (val - 1);
        i < (10 * val < this.videoTotal ? 10 * val : this.videoTotal);
        i++
      ) {
        pageList.push(this.videoList[i]);
      }
      this.pageListV = pageList;
      // document.querySelector("counter1").scrollIntoView(true); //这里的counter1是将要返回地方的id
    },

    async detail(v_id) {
      const res = await this.$http.get(`/bangumis/${v_id}`);
      this.model = res.data[0];
      this.dialogFormVisible = true;
      this.getResources();
      console.log("this.model", this.model);
    },

    async getResources() {
      console.log("getVideo");
      let rst = await this.$http.get(`/videos/`, {
        params: { v_id: this.model.v_id, t_id: this.model.t_id }
      });
      this.$store.dispatch("updateVideoList",rst.data.list);
      this.videoCurrentChange(this.videoCurrentPage);
    },

    handleClick(tab, event) {
      // if (tab.name == "second") {
      //   this.getResources();
      // }
    }
  },
  filters: {
    summarySplice(value) {
      if (!value) return "";
      value = value.toString();
      return value.substring(0, 100) + "...";
    },

    videoLinkSplice(value) {
      if (!value) return "";
      value = value.toString();
      return value.substring(0, 100) + "...";
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
  margin-left: 30px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  width: 90%;
}

.lastP {
  word-wrap: break-word;
  white-space: pre-wrap;
  overflow: visible;
}

.window-pagination {
  display: inline-block;
  margin-top: 30px;
  margin-left: 50%;
  transform: translateX(-50%);
}

.panel {
  position: relative;
  // min-height: 600px;
  overflow: auto;
  // margin-right: -26px;
}

.container{
  position: relative;
}

.video-pagination{
  display: inline-block;
  margin-top: 30px;
  margin-left: 50%;
  transform: translateX(-50%);
}
</style>
