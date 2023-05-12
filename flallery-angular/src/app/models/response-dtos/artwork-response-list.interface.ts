export interface ArtworkResponseList {
  content: ArtworkResponse[]
  totalPages: number
  totalElements: number
  pageSize: number
}

export interface ArtworkResponse {
  name: string
  uuid: string
  comments: any[]
  imgUrl: string
  disponibleParaComprar: boolean
  owner: string
  categoryName: string
  description: string
}
