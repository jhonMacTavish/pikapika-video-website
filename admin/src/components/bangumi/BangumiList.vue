<template>
  <div>
    <h1>番剧列表</h1>
    <el-table :data="pageList" stripe>
      <el-table-column type="index" width="50"></el-table-column>
      <el-table-column prop="b_name" label="名称"></el-table-column>
      <el-table-column prop="b_episodes" label="集数"></el-table-column>
      <el-table-column prop="b_style" label="风格"></el-table-column>
      <el-table-column prop="b_playtime" label="上映时间"></el-table-column>
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
        :total="totalItems"
        background
      ></el-pagination>
    </div>

    <el-dialog title="番剧信息" :visible.sync="dialogFormVisible">
      <el-form :model="model" label-width="100px" style="margin-right: 0;">
        <el-form-item label="名称" class="form-item">
          <p>{{model.b_name}}</p>
        </el-form-item>
        <el-form-item label="类型" class="form-item">
          <p>{{model.t_id}}</p>
        </el-form-item>

        <el-form-item label="总集数" class="form-item">
          <p>{{model.b_episodes}}</p>
        </el-form-item>
        <el-form-item label="状态" class="form-item">
          <p>{{model.b_status}}</p>
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
          <p>{{model.b_summary}}</p>
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
      model: {}
    };
  },
  async created() {
    await this.fetch();
  },
  computed: {
    bangumiList() {
      return this.$store.getters.bangumiList;
    },

    totalItems() {
      return this.$store.getters.bangumiList.length;
    }
  },
  beforeUpdate(){
  },
  watch: {},
  methods: {
    async fetch() {
      const res = await this.$http.get("/bangumis");
      this.$store.dispatch("updateBangumiList", res.data.list);
      console.log("this.totalItems/10", this.totalItems/10);
      console.log("this.totalItems", this.totalItems);
      console.log("this.currentPage", this.currentPage);
      
      if(Math.ceil(this.totalItems/10) < this.currentPage){
        --this.currentPage;
      }
      this.handleCurrentChange(this.currentPage);
    },

    async remove(row) {
      this.$confirm(`是否确定要删除番剧 "${row.b_name}"`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(async () => {
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
      }).catch(() => {   
        return      
        });
    },

    handleCurrentChange(val) {

      if(val < 1){
        val = 1;
      }
      let pageList = [];
      for (
        let i = 10 * (val - 1);
        i < (10 * val < this.totalItems ? 10 * val : this.totalItems);
        i++
      ) {
        pageList.push(this.bangumiList[i]);
      }
      this.pageList = pageList;
      // document.querySelector("counter1").scrollIntoView(true); //这里的counter1是将要返回地方的id
    },

    async detail(v_id) {
      const res = await this.$http.get(`/bangumis/${v_id}`);
      this.model = res.data[0];
      this.dialogFormVisible = true;
      console.log("this.model", this.model);
    }
  },
  components: {}
};
</script>

<style lang='less' scoped>
.detail{
  color: #409EFF;
}

.deit{
  color: #67C23A;
}

.delete{
  color: #F56C6C;
}

.form-item{
  font-weight: bold;
  margin: 5px 0;
}

.form-item:nth-child(even){
  background: #FAFAFA;
}

.form-item:hover{
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
