<template>
  <div class="vendor-list dashboard-card fade-in">
    <div class="list-header">
      <h2>
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <path d="M3 3h18v18H3z"/>
          <path d="M21 9H3"/>
          <path d="M21 15H3"/>
          <path d="M9 3v18"/>
          <path d="M15 3v18"/>
        </svg>
        Vendor Directory
      </h2>
      <div class="vendor-stats">
        <div class="stat-item">
          <span class="stat-number">{{ vendorStore.vendors.length }}</span>
          <span class="stat-label">Total</span>
        </div>
        <div class="stat-divider"></div>
        <div class="stat-item">
          <span class="stat-number">{{ supplierCount }}</span>
          <span class="stat-label">Suppliers</span>
        </div>
        <div class="stat-divider"></div>
        <div class="stat-item">
          <span class="stat-number">{{ partnerCount }}</span>
          <span class="stat-label">Partners</span>
        </div>
      </div>
    </div>
    
    <div v-if="vendorStore.loading" class="loading-state">
      <div class="loading-spinner-container">
        <svg class="loading-spinner" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <path d="M21 12a9 9 0 11-6.219-8.56"/>
        </svg>
        <span>Loading vendors...</span>
      </div>
    </div>
    
    <div v-else-if="vendorStore.error" class="error-state">
      <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <circle cx="12" cy="12" r="10"/>
        <line x1="15" y1="9" x2="9" y2="15"/>
        <line x1="9" y1="9" x2="15" y2="15"/>
      </svg>
      <span>{{ vendorStore.error }}</span>
    </div>
    
    <div v-else-if="vendorStore.vendors.length === 0" class="empty-state">
      <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
        <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/>
        <circle cx="9" cy="7" r="4"/>
        <path d="M22 21v-2a4 4 0 0 0-3-3.87"/>
        <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
      </svg>
      <h3>No vendors yet</h3>
      <p>Get started by adding your first vendor using the form on the left.</p>
    </div>
    
    <div v-else class="table-container">
      <table class="vendors-table">
        <thead>
          <tr>
            <th>ID</th>
            <th>Company</th>
            <th>Contact</th>
            <th>Email</th>
            <th>Type</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="vendor in vendorStore.vendors" :key="vendor.id" class="vendor-row">
            <td class="vendor-id">
              <span class="id-badge">{{ vendor.id }}</span>
            </td>
            <td class="vendor-name">
              <div class="company-info">
                <span class="company-name">{{ vendor.name }}</span>
              </div>
            </td>
            <td class="vendor-contact">
              <div class="contact-info">
                <span class="contact-name">{{ vendor.contact_person }}</span>
              </div>
            </td>
            <td class="vendor-email">
              <a :href="`mailto:${vendor.email}`" class="email-link">
                {{ vendor.email }}
              </a>
            </td>
            <td class="vendor-type">
              <span class="type-badge" :class="getTypeBadgeClass(vendor.partner_type)">
                {{ vendor.partner_type }}
              </span>
            </td>
            <td class="vendor-actions">
              <button 
                @click="confirmDelete(vendor)" 
                class="btn btn-danger btn-sm"
                :disabled="vendorStore.loading"
                title="Delete vendor"
              >
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <polyline points="3,6 5,6 21,6"/>
                  <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/>
                  <line x1="10" y1="11" x2="10" y2="17"/>
                  <line x1="14" y1="11" x2="14" y2="17"/>
                </svg>
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup lang="ts">
import { onMounted, computed } from 'vue';
import { useVendorStore } from '../stores/vendorStore';
import type { Vendor } from '../types/Vendor';

// Using the vendor store directly, no need for local props or state
const vendorStore = useVendorStore();

onMounted(() => {
  vendorStore.fetchVendors();
});

// Computed properties for vendor statistics
const supplierCount = computed(() => {
  return vendorStore.vendors.filter(vendor => vendor.partner_type === 'Supplier').length;
});

const partnerCount = computed(() => {
  return vendorStore.vendors.filter(vendor => vendor.partner_type === 'Partner').length;
});

const confirmDelete = async (vendor: Vendor) => {
  const confirmed = confirm(`Are you sure you want to delete ${vendor.name}? This action cannot be undone.`);
  if (confirmed && vendor.id) {
    try {
      await vendorStore.deleteVendor(vendor.id);
    } catch (err) {
      // Error is already handled in the store
    }
  }
};

const getTypeBadgeClass = (type: string) => {
  return type === 'Supplier' ? 'type-supplier' : 'type-partner';
};
</script>

<style scoped>
.vendor-list {
  margin: 0;
  overflow: hidden;
}

.list-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1.5rem;
  padding-bottom: 1rem;
  border-bottom: 1px solid var(--border-color);
}

.vendor-list h2 {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  margin: 0;
  font-size: 1.25rem;
  font-weight: 600;
  color: var(--text-primary);
}

.vendor-list h2::before {
  display: none;
}

.vendor-list h2 svg {
  color: var(--primary-color);
}

.vendor-stats {
  display: flex;
  align-items: center;
  gap: 1rem;
  background: linear-gradient(135deg, var(--maersk-light-blue) 0%, var(--surface-color) 100%);
  padding: 0.75rem 1rem;
  border-radius: var(--border-radius-lg);
  border: 1px solid var(--border-light);
  position: relative;
  overflow: hidden;
}

.vendor-stats::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 2px;
  background: var(--gradient-light);
}

.stat-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.25rem;
}

.stat-number {
  font-size: 1.25rem;
  font-weight: 700;
  color: var(--primary-color);
  line-height: 1;
}

.stat-label {
  font-size: 0.75rem;
  color: var(--text-secondary);
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.stat-divider {
  width: 1px;
  height: 2rem;
  background-color: var(--border-color);
}

.loading-state,
.error-state {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 3rem 2rem;
  color: var(--text-secondary);
}

.loading-spinner-container {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.loading-spinner {
  animation: spin 1s linear infinite;
}

@keyframes spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

.error-state {
  color: var(--danger-color);
  gap: 0.75rem;
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 3rem 2rem;
  text-align: center;
  color: var(--text-secondary);
  background: linear-gradient(135deg, var(--surface-color) 0%, var(--maersk-light-blue) 100%);
  border-radius: var(--border-radius-lg);
  position: relative;
  overflow: hidden;
}

.empty-state::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 3px;
  background: var(--gradient-light);
}

.empty-state svg {
  color: var(--maersk-blue-accent);
  margin-bottom: 1rem;
  opacity: 0.8;
}

.empty-state h3 {
  margin-bottom: 0.5rem;
  color: var(--text-primary);
  font-size: 1.125rem;
  font-weight: 600;
}

.empty-state p {
  color: var(--text-secondary);
  font-size: 0.875rem;
  max-width: 300px;
  line-height: 1.5;
}

.table-container {
  overflow-x: auto;
  border-radius: var(--border-radius);
  border: 1px solid var(--border-color);
}

.vendors-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.875rem;
}

.vendors-table th {
  background: linear-gradient(135deg, var(--maersk-silver) 0%, var(--surface-color) 100%);
  color: var(--text-primary);
  font-weight: 600;
  padding: 0.75rem 1rem;
  text-align: left;
  border-bottom: 2px solid var(--maersk-blue-accent);
  font-size: 0.75rem;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  position: relative;
}

.vendors-table th::after {
  content: '';
  position: absolute;
  bottom: -2px;
  left: 0;
  right: 0;
  height: 1px;
  background: var(--gradient-light);
}

.vendors-table td {
  padding: 1rem;
  border-bottom: 1px solid var(--border-color);
  vertical-align: middle;
}

.vendor-row {
  transition: background-color 0.2s ease;
}

.vendor-row:hover {
  background: linear-gradient(135deg, var(--maersk-light-blue) 0%, var(--surface-color) 100%);
}

.vendor-row:last-child td {
  border-bottom: none;
}

.vendor-id {
  width: 80px;
}

.id-badge {
  display: inline-block;
  background-color: #e2e8f0;
  color: var(--text-secondary);
  padding: 0.25rem 0.5rem;
  border-radius: 0.375rem;
  font-size: 0.75rem;
  font-weight: 500;
  font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
}

.company-info {
  display: flex;
  flex-direction: column;
}

.company-name {
  font-weight: 600;
  color: var(--text-primary);
  line-height: 1.25;
}

.contact-info {
  display: flex;
  flex-direction: column;
}

.contact-name {
  color: var(--text-primary);
  font-weight: 500;
}

.email-link {
  color: var(--primary-color);
  text-decoration: none;
  font-weight: 500;
  transition: color 0.2s ease;
}

.email-link:hover {
  color: var(--primary-dark);
  text-decoration: underline;
}

.type-badge {
  display: inline-block;
  padding: 0.25rem 0.75rem;
  border-radius: 9999px;
  font-size: 0.75rem;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.type-supplier {
  background-color: var(--maersk-light-blue);
  color: var(--maersk-blue);
  border: 1px solid var(--maersk-blue-accent);
}

.type-partner {
  background-color: var(--surface-secondary);
  color: var(--maersk-ocean);
  border: 1px solid var(--maersk-blue-light);
}

.vendor-actions {
  width: 120px;
  text-align: right;
}

.btn {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.5rem 1rem;
  border: none;
  border-radius: var(--border-radius);
  font-size: 0.875rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;
  text-decoration: none;
  outline: none;
}

.btn-sm {
  padding: 0.375rem 0.75rem;
  font-size: 0.75rem;
}

.btn-danger {
  background-color: var(--danger-color);
  color: white;
}

.btn-danger:hover:not(:disabled) {
  background-color: #dc2626;
  transform: translateY(-1px);
  box-shadow: var(--shadow-sm);
}

.btn-danger:active {
  transform: translateY(0);
}

.btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
  transform: none;
}

/* Mobile responsive */
@media (max-width: 768px) {
  .list-header {
    flex-direction: column;
    gap: 1rem;
    align-items: flex-start;
  }
  
  .vendor-stats {
    padding: 0.5rem 0.75rem;
    gap: 0.75rem;
  }
  
  .stat-number {
    font-size: 1rem;
  }
  
  .stat-label {
    font-size: 0.625rem;
  }
  
  .stat-divider {
    height: 1.5rem;
  }
  
  .table-container {
    border-radius: 0;
    border-left: none;
    border-right: none;
  }
  
  .vendors-table {
    font-size: 0.75rem;
  }
  
  .vendors-table th,
  .vendors-table td {
    padding: 0.5rem;
  }
  
  .vendor-id {
    width: 60px;
  }
  
  .id-badge {
    font-size: 0.625rem;
    padding: 0.125rem 0.375rem;
  }
  
  .company-name {
    font-size: 0.875rem;
  }
  
  .contact-name {
    font-size: 0.75rem;
  }
  
  .email-link {
    font-size: 0.75rem;
  }
  
  .type-badge {
    font-size: 0.625rem;
    padding: 0.125rem 0.5rem;
  }
  
  .vendor-actions {
    width: 80px;
  }
  
  .btn-sm {
    padding: 0.25rem 0.5rem;
    font-size: 0.625rem;
  }
  
  .btn-sm svg {
    width: 12px;
    height: 12px;
  }
}

/* Very small screens */
@media (max-width: 480px) {
  .vendors-table th:nth-child(3),
  .vendors-table td:nth-child(3) {
    display: none;
  }
  
  .btn-sm span {
    display: none;
  }
}
</style>