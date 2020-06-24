<template>
  <div class="content">
    <h1>国漫列表</h1>
    <div>
      <el-button type="text" @click="$router.push('/guoman/create')">
        <i class="el-icon-plus"></i>添加国漫
      </el-button>
      <el-input
        class="searchInput"
        :clearable="true"
        v-model="search"
        size="small"
        placeholder="输入关键字搜索"
        prefix-icon="el-icon-search"
      />
    </div>
    <el-table :data="pageList.filter(data=>!search || data.name.toLowerCase().includes(search.toLowerCase()))" stripe>
      <el-table-column type="index" width="50"></el-table-column>
      <el-table-column prop="name" label="名称"></el-table-column>
      <el-table-column prop="episodes" label="集数" width="120"></el-table-column>
      <el-table-column
        prop="is_ended"
        label="状态"
        width="120"
        :filters="[{text:'更新中',value:0},{text:'已完结',value:1}]"
        :filter-method="filterTag"
        filter-placement="top"
      >
        <template slot-scope="scope">
          <el-tag :type="scope.row.is_ended?'primary':'success'">{{scope.row.is_ended?"已完结":"更新中"}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="style" label="风格" width="280"></el-table-column>
      <el-table-column prop="playtime" label="开播时间" width="160"></el-table-column>
      <el-table-column label="操作" width="180">
        <template slot-scope="scope">
          <el-button type="text" size="small" @click="detail(scope.row.film_id)" class="detail">查看</el-button>
          <el-button
            type="text"
            size="small"
            @click="$router.push(`/guoman/eidt/${scope.row.film_id}`)"
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

    <el-dialog title="国漫信息" :visible.sync="dialogFormVisible">
      <el-tabs type="border-card" v-model="activeName" @tab-click="handleClick">
        <el-tab-pane label="基本信息" name="first" class="panel">
          <el-form :model="model" label-width="100px" style="margin-right: 0;">
            <el-form-item label="名称" class="form-item">
              <p>{{model.name}}</p>
            </el-form-item>
            <el-form-item label="类型" class="form-item">
              <p>{{model.type_id==1?"番剧":model.type_id==2?"国漫":model.type_id==3?"电影":"影视"}}</p>
            </el-form-item>

            <el-form-item label="总集数" class="form-item">
              <p>{{model.episodes}}</p>
            </el-form-item>
            <el-form-item label="状态" class="form-item">
              <p>{{model.status==1?"更新中":"已完结"}}</p>
            </el-form-item>
            <el-form-item label="风格" class="form-item">
              <p>{{model.style}}</p>
            </el-form-item>
            <el-form-item label="首字母" class="form-item">
              <p>{{model.initials}}</p>
            </el-form-item>
            <el-form-item label="开播时间" class="form-item">
              <p>{{model.playtime}}</p>
            </el-form-item>
            <el-form-item label="主演" class="form-item">
              <p>{{model.actors}}</p>
            </el-form-item>
            <el-form-item label="图片地址" class="form-item">
              <p>{{model.imgSrc}}</p>
            </el-form-item>
            <el-form-item label="简介" class="form-item">
              <p>{{model.summary | summarySplice}}</p>
            </el-form-item>
          </el-form>
        </el-tab-pane>
        <el-tab-pane label="视频资源" name="second" class="panel">
          <el-table :data="pageListV" stripe>
            <!-- <el-table-column type="index" width="50"></el-table-column> -->
            <el-table-column prop="episode" label="章节" width="50"></el-table-column>
            <el-table-column prop="src" label="视频链接">
              <template slot-scope="scope">{{scope.row.src | videoLinkSplice}}</template>
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
      search: "",
      dialogFormVisible: false,
      pageList: [],
      currentPage: 1,
      model: {},
      activeName: "first",
      videoCurrentPage: 1,
      pageListV: []
    };
  },
  async created() {
    // await this.fetch();
  },
  computed: {
    guomanList() {
      return this.$store.getters.guomanList;
    },

    totalItems() {
      return this.$store.getters.guomanList.length;
    },

    videoList() {
      return this.$store.getters.videoList;
    },

    videoTotal() {
      return this.$store.getters.videoList.length;
    }
  },
  beforeUpdate() {},
  watch: {
    search(newV,oldV){
      if(newV){
        this.pageList = this.theaterList;
      }else{
        this.handleCurrentChange(this.currentPage);
      }
    }},
  methods: {
    filterTag(value, row) {
      return row.is_ended == value;
    },
    async fetch() {
      const res = await this.$http.get("/guomans");
      // //console.log("guomanList", res.data.list);
      this.$store.dispatch("updateGuomanList", res.data.list);

      if (Math.ceil(this.totalItems / 10) < this.currentPage) {
        --this.currentPage;
      }
      this.handleCurrentChange(this.currentPage);
    },

    async remove(row) {
      this.$confirm(`是否确定要删除国漫 "${row.name}"`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(async () => {
          // const resC = await this.$http.delete(`/comments/${row.film_id}`);
          let params = {
            type_id: 2,
            film_id: row.film_id
          };
          const resC = await this.$http.delete(`/comments`, { params });

          //console.log("delete", resC);

          if (resC.data.status == 200) {
            // const resV = await this.$http.delete(`/videos/${row.film_id}`);
            const resV = await this.$http.delete(`/videos`, { params });

            //console.log("delete", resV);

            if (resV.data.status == 200) {
              const resB = await this.$http.delete(`/guomans/${row.film_id}`);
              //console.log("delete", resB);

              if (resB.data.status == 200) {
                this.$message({
                  type: "success",
                  message: resC.data.msg
                });
                this.fetch();
              } else {
                this.$message({
                  type: "error",
                  message: resB.data.msg
                });
              }
            } else {
              this.$message({
                type: "error",
                message: resV.data.msg
              });
            }

            //   this.$message({
            //     type: "success",
            //     message: resC.data.msg
            //   });
            //   this.fetch();
          } else {
            this.$message({
              type: "error",
              message: resC.data.msg
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
        pageList.push(this.guomanList[i]);
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

    async detail(film_id) {
      const res = await this.$http.get(`/guomans/${film_id}`);
      res.data[0] ? (this.model = res.data[0]) : "";
      this.dialogFormVisible = true;
      this.getResources();
      // //console.log("this.model", this.model);
    },

    async getResources() {
      // //console.log("getVideo");
      let rst = await this.$http.get(`/videos/`, {
        params: { film_id: this.model.film_id, type_id: this.model.type_id }
      });
      // //console.log("rst", rst);
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
  components: {},
  beforeRouteEnter(to, from, next) {
    next(async vm => {
      await vm.fetch();
    });
  }
};
</script>

<style lang='less' scoped>
.searchInput {
  margin-right: 63px;
  width: 360px;
  float: right;
}

.searchInput::after {
  content: "";
  display: block;
  visibility: hidden;
  clear: both;
}
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

.panel {
  position: relative;
  // min-height: 600px;
  overflow: auto;
  // margin-right: -26px;
}

.video-pagination {
  display: inline-block;
  margin-top: 30px;
  margin-left: 50%;
  transform: translateX(-50%);
}
</style>
