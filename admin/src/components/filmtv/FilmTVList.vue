<template>
  <div class="content">
    <h1>影视列表</h1>
    <div>
      <el-button type="text" @click="$router.push('/filmtv/create')">
        <i class="el-icon-plus"></i>添加影视
      </el-button>
    </div>
    <el-table :data="pageList" stripe>
      <el-table-column type="index" width="50"></el-table-column>
      <el-table-column prop="f_name" label="名称"></el-table-column>
      <el-table-column prop="f_episodes" label="集数"></el-table-column>
      <el-table-column prop="f_style" label="风格"></el-table-column>
      <el-table-column prop="f_playtime" label="开播时间"></el-table-column>
      <el-table-column fixed="right" label="操作" width="180">
        <template slot-scope="scope">
          <el-button type="text" size="small" @click="detail(scope.row.v_id)" class="detail">查看</el-button>
          <el-button
            type="text"
            size="small"
            @click="$router.push(`/filmtv/eidt/${scope.row.v_id}`)"
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
        :total="totalItems"
        background
      ></el-pagination>
    </div>

    <el-dialog title="番剧信息" :visible.sync="dialogFormVisible">
      <el-tabs type="border-card" v-model="activeName" @tab-click="handleClick">
        <el-tab-pane label="基本信息" name="first" class="panel">
          <el-form :model="model" label-width="100px" style="margin-right: 0;">
            <el-form-item label="名称" class="form-item">
              <p>{{model.f_name}}</p>
            </el-form-item>
            <el-form-item label="类型" class="form-item">
              <p>{{model.t_id==1?"番剧":model.t_id==2?"国漫":model.t_id==3?"电影":"影视"}}</p>
            </el-form-item>

            <el-form-item label="总集数" class="form-item">
              <p>{{model.f_episodes}}</p>
            </el-form-item>
            <el-form-item label="状态" class="form-item">
              <p>{{model.b_status==1?"更新中":"已完结"}}</p>
            </el-form-item>
            <el-form-item label="风格" class="form-item">
              <p>{{model.f_style}}</p>
            </el-form-item>
            <el-form-item label="首字母" class="form-item">
              <p>{{model.f_initials}}</p>
            </el-form-item>
            <el-form-item label="开播时间" class="form-item">
              <p>{{model.f_playtime}}</p>
            </el-form-item>
            <el-form-item label="声优" class="form-item">
              <p>{{model.f_actors}}</p>
            </el-form-item>
            <el-form-item label="图片地址" class="form-item">
              <p>{{model.f_imgSrc}}</p>
            </el-form-item>
            <el-form-item label="简介" class="form-item">
              <p>{{model.f_summary}}</p>
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
      </div>-->
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "GuomanList",
  data() {
    return {
      dialogFormVisible: false,
      pageList: [],
      pageListV: [],
      currentPage: 1,
      videoCurrentPage: 1,
      model: {},
      activeName: "first"
    };
  },
  async created() {
    await this.fetch();
  },
  computed: {
    filmtvList() {
      return this.$store.getters.filmtvList;
    },

    totalItems() {
      return this.$store.getters.filmtvList.length;
    },

    videoList() {
      return this.$store.getters.videoList;
    },

    videoTotal() {
      return this.$store.getters.videoList.length;
    }
  },
  beforeUpdate() {},
  watch: {},
  methods: {
    async fetch() {
      const res = await this.$http.get("/filmtvs");
      console.log("res", res.data.list);
      this.$store.dispatch("updateFilmtvList", res.data.list);

      if (Math.ceil(this.totalItems / 10) < this.currentPage) {
        --this.currentPage;
      }
      this.handleCurrentChange(this.currentPage);
    },

    async remove(row) {
      this.$confirm(`是否确定要删除影视 "${row.f_name}"`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(async () => {
          const res = await this.$http.delete(`/filmtvs/${row.v_id}`);
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
        pageList.push(this.filmtvList[i]);
      }
      this.pageList = pageList;
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
      const res = await this.$http.get(`/filmtvs/${v_id}`);
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
      this.$store.dispatch("updateVideoList", rst.data.list);
      this.videoCurrentChange(this.videoCurrentPage);
    },

    handleClick() {}
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
  margin-left: 50px;
}
.window-pagination {
  display: inline-block;
  margin-top: 30px;
  margin-left: 50%;
  transform: translateX(-50%);
}
</style>
