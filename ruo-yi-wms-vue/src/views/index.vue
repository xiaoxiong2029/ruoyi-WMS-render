<template>
  <div class="app-container home">
    <el-row :gutter="20" class="pl20 pr20 pb20 pt20">
      <!-- 公司介绍主卡片 -->
      <el-col :span="24">
        <el-card shadow="always" class="intro-card">
          <div slot="header" class="clearfix">
            <span class="card-title">
              <i class="el-icon-s-home"></i> 荣租办公设备有限公司
            </span>
            <el-tag type="danger" size="mini" style="float: right;">内部仓管系统</el-tag>
          </div>
          <div class="company-desc">
            <p>荣租办公设备有限公司专注于复印机<span class="highlight">租赁服务</span>，维修<span class="highlight">全包</span>，无需客户操心。公司自有配件仓库，确保维修响应迅速。</p >
            <p>本系统用于管理仓库内所有维修配件的<span class="highlight">采购入库、维修领料、库存盘点</span>，实现精细化管理。</p >
          </div>
        </el-card>
      </el-col>

      <!-- 配件详细清单（可折叠分组） -->
      <el-col :span="24" style="margin-top: 20px;">
        <el-card shadow="hover">
          <div slot="header">
            <span style="font-size: 1.2rem;"><i class="el-icon-goods"></i> 维修配件清单（施乐机型）</span>
            <el-button type="text" style="float: right;" @click="expandAll = !expandAll">
              {{ expandAll ? '收起全部' : '展开全部' }}
            </el-button>
          </div>
          <el-collapse v-model="activeNames" accordion>
            <!-- 定影器组件 -->
            <el-collapse-item title="🔥 定影器组件" name="fuser">
              <el-tag type="info" size="small" class="part-tag">定影器总成</el-tag>
              <el-tag type="info" size="small" class="part-tag">热辊</el-tag>
              <el-tag type="info" size="small" class="part-tag">压辊</el-tag>
              <el-tag type="info" size="small" class="part-tag">热敏电阻</el-tag>
              <el-tag type="info" size="small" class="part-tag">恒温器</el-tag>
              <el-tag type="info" size="small" class="part-tag">加热灯管</el-tag>
            </el-collapse-item>

            <!-- 鼓组件与消耗品 -->
            <el-collapse-item title="🖨️ 鼓组件及消耗品" name="drum">
              <div><strong>鼓刮板</strong>（适用：7030/8035/3371/3375）</div>
              <div><strong>转印刮板</strong></div>
              <div><strong>鼓芯</strong>（感光鼓）</div>
              <div><strong>充电棍</strong></div>
              <div><strong>海绵棒</strong></div>
              <div><strong>显影仓</strong>（含载体）</div>
            </el-collapse-item>

            <!-- 粉盒（碳粉） -->
            <el-collapse-item title="🎨 粉盒（碳粉）" name="toner">
              <div class="color-tags">
                <span class="color-tag black">黑色</span>
                <span class="color-tag cyan">青色</span>
                <span class="color-tag magenta">品红色</span>
                <span class="color-tag yellow">黄色</span>
              </div>
              <div>适用机型：7030 / 8035 / 3371 / 3375 等</div>
            </el-collapse-item>

            <!-- 电路板与电子部件 -->
            <el-collapse-item title="🔌 电路板与电子部件" name="board">
              <el-tag type="warning" size="small" class="part-tag">主控板</el-tag>
              <el-tag type="warning" size="small" class="part-tag">电源板</el-tag>
              <el-tag type="warning" size="small" class="part-tag">高压板</el-tag>
              <el-tag type="warning" size="small" class="part-tag">驱动板</el-tag>
              <el-tag type="warning" size="small" class="part-tag">接口板</el-tag>
              <el-tag type="warning" size="small" class="part-tag">面板控制板</el-tag>
            </el-collapse-item>

            <!-- 进纸与搓纸组件 -->
            <el-collapse-item title="📄 进纸与搓纸组件" name="feed">
              <el-tag size="small" class="part-tag">搓纸轮</el-tag>
              <el-tag size="small" class="part-tag">分离轮</el-tag>
              <el-tag size="small" class="part-tag">阻尼垫</el-tag>
              <el-tag size="small" class="part-tag">进纸离合器</el-tag>
              <el-tag size="small" class="part-tag">输纸皮带</el-tag>
            </el-collapse-item>

            <!-- 其他常见耗材 -->
            <el-collapse-item title="🔧 其他常用配件" name="other">
              <el-tag size="small" class="part-tag">转印组件</el-tag>
              <el-tag size="small" class="part-tag">硒鼓组件</el-tag>
              <el-tag size="small" class="part-tag">显影磁辊</el-tag>
              <el-tag size="small" class="part-tag">废粉盒</el-tag>
              <el-tag size="small" class="part-tag">传感器</el-tag>
            </el-collapse-item>
          </el-collapse>
          <div class="model-note">※ 适用机型：DocuCentre 7030 / 8035 / 3371 / 3375 等</div>
        </el-card>
      </el-col>

      <!-- 系统使用说明卡片 -->
      <el-col :span="12" style="margin-top: 20px;">
        <el-card shadow="hover" class="step-card">
          <div slot="header">
            <span><i class="el-icon-upload2"></i> 采购入库</span>
          </div>
          <div>采购员购买配件后，在系统内创建采购订单 → 确认入库，库存自动增加。</div>
          <el-tag type="success" size="small" style="margin-top: 10px;">示例：采购5个3375黑色粉盒 → 荣租总仓 +5</el-tag>
        </el-card>
      </el-col>
      <el-col :span="12" style="margin-top: 20px;">
        <el-card shadow="hover" class="step-card">
          <div slot="header">
            <span><i class="el-icon-download"></i> 维修领料</span>
          </div>
          <div>维修师傅外出修理机器时，仓管员创建领料单 → 指定配件与数量 → 确认出库，库存自动扣减。</div>
          <el-tag type="warning" size="small" style="margin-top: 10px;">示例：领用1个3371定影器 → 库存-1</el-tag>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<style scoped>
.card-title {
  font-size: 1.3rem;
  font-weight: bold;
  background: linear-gradient(135deg, #409EFF, #36D1DC);
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
}
.company-desc {
  font-size: 1rem;
  line-height: 1.8;
  color: #303133;
}
.highlight {
  font-weight: bold;
  color: #E6A23C;
  padding: 0 2px;
}
.part-tag {
  margin: 0 8px 8px 0;
}
.model-note {
  margin-top: 15px;
  font-size: 12px;
  color: #909399;
  border-top: 1px dashed #EBEEF5;
  padding-top: 12px;
}
.color-tags {
  display: flex;
  gap: 12px;
  margin: 10px 0;
}
.color-tag {
  display: inline-block;
  width: 50px;
  height: 30px;
  line-height: 30px;
  border-radius: 15px;
  text-align: center;
  color: white;
  font-weight: bold;
  font-size: 12px;
}
.black { background-color: #2c3e50; }
.cyan { background-color: #00BCD4; }
.magenta { background-color: #E91E63; }
.yellow { background-color: #FFC107; color: #333; }
.step-card {
  height: 100%;
}
</style>

<script>
export default {
  data() {
    return {
      activeNames: [],    // 默认折叠所有，可以改成 ['fuser'] 让定影器默认展开
      expandAll: false
    };
  },
  watch: {
    expandAll(val) {
      if (val) {
        this.activeNames = ['fuser', 'drum', 'toner', 'board', 'feed', 'other'];
      } else {
        this.activeNames = [];
      }
    }
  }
};
</script>

