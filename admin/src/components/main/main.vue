<template>
  <el-container style="height: 100vh; border: 1px solid #eee">
    <el-aside width="200px">
      <el-menu class="menu" router unique-opened :default-active="$route.path">
        <el-submenu index="1">
          <template slot="title">
            <i class="el-icon-film"></i>视频管理
          </template>
          <el-menu-item index="/bangumi/list" class="menu-item">番剧</el-menu-item>
          <el-menu-item index="/guoman/list" class="menu-item">国漫</el-menu-item>
          <el-menu-item index="/theater/list" class="menu-item">电影</el-menu-item>
          <el-menu-item index="/filmtv/list" class="menu-item">影视</el-menu-item>
        </el-submenu>
        <el-submenu index="2">
          <template slot="title">
            <i class="el-icon-set-up"></i>运营管理
          </template>
            <el-menu-item index="/carousel/list" class="menu-item">首页轮播图</el-menu-item>
            <el-menu-item index="/ads/list" class="menu-item">广告管理</el-menu-item>
            <el-menu-item index="/announce/list" class="menu-item">公告管理</el-menu-item>
            <el-menu-item index="/report/list" class="menu-item">举报处理</el-menu-item>
        </el-submenu>
        <el-submenu index="3">
          <template slot="title">
            <i class="el-icon-user"></i>用户管理
          </template>
          <el-menu-item-group>
            <template slot="title">普通用户</template>
            <el-menu-item index="/userinfo/list" class="menu-item">用户列表</el-menu-item>
          </el-menu-item-group>
          <el-menu-item-group v-if="adminUser.superAdmin==1">
            <template slot="title">管理员用户</template>
            <el-menu-item index="/adminuser/list" class="menu-item">管理员列表</el-menu-item>
          </el-menu-item-group>
        </el-submenu>
      </el-menu>
    </el-aside>

    <el-container>
      <el-header style="text-align: right; font-size: 16px; min-width: 1100px;">
        <el-dropdown>
          <i class="el-icon-setting setting" style="margin-right: 15px"></i>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item @click.native="$router.push('/')">退出</el-dropdown-item>
            <!-- <el-dropdown-item>新增</el-dropdown-item> -->
            <el-dropdown-item @click.native="logout">注销</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
          <span style="color:black" v-if="adminUser.name">管理员：{{adminUser.name}}</span>
      </el-header>

      <el-main class="main-container">
        <keep-alive :exclude="cachedViews">
          <router-view></router-view>
        </keep-alive>
      </el-main>
    </el-container>
  </el-container>
</template>

<style>
.main-container {
  position: relative;
  min-width: 1100px;
}

.close-button {
  position: absolute;
}

i {
  position: relative;
  top: -1px;
}

i.setting{
  position: relative;
  top: 2px;
  font-size: 20px;
}

i.setting:hover{
  cursor: pointer;
}

.el-header {
  background-color: #73c9e5;
  color: #333;
  line-height: 60px;
}

.el-aside {
  color: #333;
  background: url("../../../static/asideImg.png");
  background-position: center 100%;
  background-size: auto 520px;
  background-repeat: no-repeat;
}
.el-menu{
  background: rgba(255, 255, 255, 0.8);
}

</style>

<script>
export default {
  data() {
    return {
      // tableData: Array(20).fill(item),
      cachedViews: [
        "BangumiEdit",
        "GuomanEdit",
        "TheaterEdit",
        "FilmTVEdit",
        "UserinfoEdit",
        "AdminUserEdit"
      ],
      adminUser: {
        superAdmin: 0,
        name: ""
      }
    };
  },
  watch:{
    async '$route'(to,from){
      //console.log("to", to);
    }
  },
  computed: {
    // is_super_admin() {
    //   //console.log(this.$store.getters.adminUser, );
    //   return this.$store.getters.adminUser.superAdmin||0;
    // },

    user() {
      return localStorage.adminUserName;
    }
  },
  created() {
    this.fetch();
  },
  methods: {
    async fetch() {
      let res = await this.$http.get("/adminUser");
      this.adminUser = res.data.adminUser;
      this.$store.commit("UpdateAdminUser",this.adminUser);
    },

    logout() {
      sessionStorage.removeItem("adminUser");
      localStorage.clear();
      this.$router.push("/login");
    }
  }
};
</script>