export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  public: {
    Tables: {
      users: {
        Row: {
          id: string
          created_at: string
          email: string
          user_type: 'homeowner' | 'professional' | 'admin'
          full_name: string | null
          phone_number: string | null
          profile_image_url: string | null
        }
        Insert: {
          id: string
          created_at?: string
          email: string
          user_type: 'homeowner' | 'professional' | 'admin'
          full_name?: string | null
          phone_number?: string | null
          profile_image_url?: string | null
        }
        Update: {
          id?: string
          created_at?: string
          email?: string
          user_type?: 'homeowner' | 'professional' | 'admin'
          full_name?: string | null
          phone_number?: string | null
          profile_image_url?: string | null
        }
      }
      service_categories: {
        Row: {
          id: string
          name: string
          description: string | null
          icon_url: string | null
          is_active: boolean
          created_at: string
        }
        Insert: {
          id?: string
          name: string
          description?: string | null
          icon_url?: string | null
          is_active?: boolean
          created_at?: string
        }
        Update: {
          id?: string
          name?: string
          description?: string | null
          icon_url?: string | null
          is_active?: boolean
          created_at?: string
        }
      }
      service_requests: {
        Row: {
          id: string
          user_id: string
          category_id: string
          description: string
          location: string
          status: 'pending' | 'accepted' | 'in_progress' | 'completed' | 'cancelled'
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          user_id: string
          category_id: string
          description: string
          location: string
          status?: 'pending' | 'accepted' | 'in_progress' | 'completed' | 'cancelled'
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          category_id?: string
          description?: string
          location?: string
          status?: 'pending' | 'accepted' | 'in_progress' | 'completed' | 'cancelled'
          created_at?: string
          updated_at?: string
        }
      }
    }
    Functions: {
      get_service_categories: {
        Args: {
          p_is_active: boolean
        }
        Returns: {
          id: string
          name: string
          description: string | null
          icon_url: string | null
          is_active: boolean
        }[]
      }
      get_user_type: {
        Args: {
          p_user_id: string
        }
        Returns: string
      }
      set_user_type: {
        Args: {
          p_user_id: string
          p_user_type: string
        }
        Returns: void
      }
      handle_error: {
        Args: {
          p_error_message: string
          p_context: string
          p_additional_data?: Json
        }
        Returns: void
      }
    }
  }
}
